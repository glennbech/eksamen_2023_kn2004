# Build / install application
FROM maven:3.8.6-openjdk-11-slim as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package

# Start application
FROM adoptopenjdk/openjdk11:alpine-slim
COPY --from=builder /app/target/*.jar /app/application.jar
ENTRYPOINT ["java","-jar","/app/application.jar"]