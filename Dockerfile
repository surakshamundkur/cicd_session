# Use a base image with JDK
FROM openjdk:11-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file from the target directory into the container
COPY target/cicd-session-1.0-SNAPSHOT.jar /app/app.jar

# Expose port 9000 (the port your application is running on)
EXPOSE 9000

# Command to run the Java application when the container starts
CMD ["java", "-jar", "app.jar"]
