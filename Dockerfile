# Use the official OpenJDK image as the base image
FROM openjdk:21-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from your local machine (from the target folder) to the container
COPY target/student-management-system-0.0.1-SNAPSHOT.jar /app/student-management-system-0.0.1-SNAPSHOT.jar

# Expose port 8080 (default for Spring Boot applications)
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "/app/student-management-system-0.0.1-SNAPSHOT.jar"]
