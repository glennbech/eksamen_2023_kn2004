package com.example.s3rekognition.controller;

import com.amazonaws.services.rekognition.AmazonRekognition;
import com.amazonaws.services.rekognition.AmazonRekognitionClientBuilder;
import com.amazonaws.services.rekognition.model.*;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ListObjectsV2Result;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.example.s3rekognition.PPEClassificationResponse;
import com.example.s3rekognition.PPEResponse;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

import io.micrometer.core.annotation.Timed;
import io.micrometer.core.instrument.*;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;


@RestController
public class RekognitionController implements ApplicationListener<ApplicationReadyEvent> {

    private final AmazonS3 s3Client;
    private final AmazonRekognition rekognitionClient;

    private static final Logger logger = Logger.getLogger(RekognitionController.class.getName());

    private MeterRegistry meterRegistry;
    
    private int numViolations = 0;
    
    @Autowired
    public RekognitionController(MeterRegistry meterRegistry) {
        this.s3Client = AmazonS3ClientBuilder.standard().build();
        this.rekognitionClient = AmazonRekognitionClientBuilder.standard().build();
        this.meterRegistry = meterRegistry;
    }
    

    /**
     * This endpoint takes an S3 bucket name in as an argument, scans all the
     * Files in the bucket for Protective Gear Violations.
     * <p>
     *
     * @param bucketName
     * @return
     */
    @GetMapping(value = "/scan-ppe", consumes = "*/*", produces = "application/json")
    @ResponseBody
    public ResponseEntity<PPEResponse> scanForPPE(@RequestParam String bucketName) {
        // List all objects in the S3 bucket
        ListObjectsV2Result imageList = s3Client.listObjectsV2(bucketName);

        // This will hold all of our classifications
        List<PPEClassificationResponse> classificationResponses = new ArrayList<>();

        // This is all the images in the bucket
        List<S3ObjectSummary> images = imageList.getObjectSummaries();

        // Iterate over each object and scan for PPE
        for (S3ObjectSummary image : images) {
            logger.info("scanning " + image.getKey());
            
            // start timer so that we can see how long it took to scan this image
            Timer.Sample timer = Timer.start(meterRegistry);

            // This is where the magic happens, use AWS rekognition to detect PPE for this image
            DetectProtectiveEquipmentRequest request = new DetectProtectiveEquipmentRequest()
                    .withImage(new Image()
                            .withS3Object(new S3Object()
                                    .withBucket(bucketName)
                                    .withName(image.getKey())))
                    .withSummarizationAttributes(new ProtectiveEquipmentSummarizationAttributes()
                            .withMinConfidence(80f)
                            .withRequiredEquipmentTypes("FACE_COVER", "HEAD_COVER"));

            DetectProtectiveEquipmentResult result = rekognitionClient.detectProtectiveEquipment(request);
            
            int personCount = result.getPersons().size();
            int faceViolations = 0;
            int headViolations = 0;

            boolean violation = false;
            
            // No point checking if there are any violations if people detected is 0
           if(0 < personCount){
                // If any person on an image lacks PPE on the face or head, it's a violation of regulations
                faceViolations = faceViolations(result);
                headViolations = headViolations(result);
                if(0 < faceViolations || 0 < headViolations) {
                    violation = true;
                }
           } 
           
            logger.info("scanning " + image.getKey() + ", violation result " + violation + ", total violations " + (faceViolations + headViolations) + ", facial violations " + faceViolations + ", head violations " + headViolations);
            
            PPEClassificationResponse classification = new PPEClassificationResponse(image.getKey(), personCount, violation, faceViolations, headViolations);
            
            classificationResponses.add(classification);
            
            // Stop and uploat timer
            timer.stop(meterRegistry.timer("ppe_image_scan_time"));
            
            meterRegistry.counter("people_scanned").increment((double) personCount);
            meterRegistry.counter("head_violations").increment((double) headViolations);
            meterRegistry.counter("facial_violations").increment((double) faceViolations);
            meterRegistry.counter("total_violations").increment((double) faceViolations + headViolations);
            
            // I have the counter here so that if for some reason an image crashes the program the ones earlier are still added to the counter.
            meterRegistry.counter("images_scanned").increment();
        }
        
        PPEResponse ppeResponse = new PPEResponse(bucketName, classificationResponses);
        
        return ResponseEntity.ok(ppeResponse);
    }

    /**
     * Detects if the image has a protective gear violation for the FACE bodypart-
     * It does so by iterating over all persons in a picture, and then again over
     * each body part of the person. If the body part is a FACE and there is no
     * protective gear on it, a violation is recorded for the picture.
     *
     * @param result
     * @return
     */
    private static int faceViolations(DetectProtectiveEquipmentResult result) {
        return (int) result.getPersons().stream()
                .flatMap(p -> p.getBodyParts().stream())
                .filter(bodyPart -> bodyPart.getName().equals("FACE")
                        // Not certain how this reacts to other things besides masks, such as sun-glasses etc. ?
                        && bodyPart.getEquipmentDetections().isEmpty())
                .count();
    }
    
    private static int headViolations(DetectProtectiveEquipmentResult result) {
        return (int) result.getPersons().stream()
                .flatMap(p -> p.getBodyParts().stream())
                .filter(bodyPart -> bodyPart.getName().equals("HEAD")
                        // Potential limitations: haven't done too much testing, so I think it potentially might consider things like hats and hoods enough to not get a violation
                        && bodyPart.getEquipmentDetections().isEmpty())
                .count();
    }
    
    
    
    @GetMapping (value = "/testmetrics")
    public ResponseEntity<String> testMetrics (){
        Counter counter = meterRegistry.counter("test.counter");
        counter.increment();
        
        return ResponseEntity.ok("Test counter incremented.");
        
    }


    @Override
    public void onApplicationEvent(ApplicationReadyEvent applicationReadyEvent) {
        

    }
}
