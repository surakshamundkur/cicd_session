# Use a base image with JDK
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the compiled Java application into the container
COPY src/Main.java /app

# Compile the Java application
RUN javac Main.java

# Expose port 9000
EXPOSE 9000

# Define the command to run the application
CMD ["java", "Main"]
