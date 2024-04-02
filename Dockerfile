# Use a base image with Java installed
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the application source code into the container
COPY . /app

# Expose port 9000 (assuming your Spring Boot application runs on port 9000)
EXPOSE 9000

# Define the command to run the application when the container starts
CMD ["java", "-jar", "app.jar"]
