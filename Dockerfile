FROM openjdk:11-jdk-slim

WORKDIR /app

COPY Main.java /app

# Compile the Java application
RUN javac Main.java

# Expose port 9000
EXPOSE 9000

# Command to run the application
CMD ["java", "Main"]
