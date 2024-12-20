# Use the official OpenJDK image as the base image
FROM openjdk:21-jdk-slim

# Install necessary tools and Sonar Scanner
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip sonar-scanner-cli-5.0.1.3006-linux.zip && \
    mv sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner && \
    rm sonar-scanner-cli-5.0.1.3006-linux.zip && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from your local machine (from the target folder) to the container
COPY target/student-management-system-0.0.1-SNAPSHOT.jar /app/student-management-system-0.0.1-SNAPSHOT.jar

# Expose port 8080 (default for Spring Boot applications)
EXPOSE 8080

# Set an entrypoint for Sonar analysis and running the application
ENTRYPOINT ["java", "-jar", "/app/student-management-system-0.0.1-SNAPSHOT.jar"]

# Add a separate CMD for running Sonar Scanner (optional, for debugging Sonar integration)
CMD ["sonar-scanner", "-Dsonar.projectKey=student-management-system", "-Dsonar.sources=/app/src", "-Dsonar.host.url=http://<sonarqube-url>", "-Dsonar.login=<sonarqube-token>"]
