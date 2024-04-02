# Use AdoptOpenJDK 11 as base image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the Maven build output directory to the container
COPY target/*.jar /app/app.jar

# Expose port 9000
EXPOSE 9000

# Command to run the application when the container starts
CMD ["java", "-jar", "app.jar"]
