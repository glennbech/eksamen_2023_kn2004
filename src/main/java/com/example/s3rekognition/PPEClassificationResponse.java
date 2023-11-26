package com.example.s3rekognition;

import java.io.Serializable;

public class PPEClassificationResponse  implements Serializable  {

    private String fileName;
    private boolean violation;
    private int personCount;
    private int faceViolations;

    public PPEClassificationResponse(String fileName, int personCount, boolean violation, int faceViolations) {
        this.fileName = fileName;
        this.personCount = personCount;
        this.violation = violation;
        this.faceViolations = faceViolations;
    }

    public String getFileName() {
        return fileName;
    }

    public boolean isViolation() {
        return violation;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setViolation(boolean violation) {
        this.violation = violation;
    }

    public int getPersonCount() {
        return personCount;
    }

    public void setPersonCount(int personCount) {
        this.personCount = personCount;
    }
    
    public int getFaceViolations() {
        return faceViolations;
    }

    public void setFaceViolations(int faceViolations) {
        this.faceViolations = faceViolations;
    }
}
