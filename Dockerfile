# Use a base image with Java 11 installed
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file built by Maven to the container
COPY target/demo-1.0-SNAPSHOT.jar /app/app.jar

# Expose port 9000 to the outside world
EXPOSE 9000

# Command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "app.jar"]
