pipeline {
    agent any

    tools {
        // Define Maven tool named 'maven' configured in Global Tool Configuration
        maven 'maven'
        // Define Docker tool named 'docker' configured in Global Tool Configuration
        dockerTool 'docker'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository into the workspace
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/surakshamundkur/cicd_session.git']]])
            }
        }

        stage('Build') {
            steps {
                // Print current working directory
                sh 'pwd'
                
                // List contents of current directory
                sh 'ls -la'

                // Use 'mvn' command to clean and package the Maven project
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Print current working directory
                sh 'pwd'
                
                // List contents of current directory
                sh 'ls -la'

                // Run unit tests using Maven
                sh 'mvn test'
            }
        }

        stage('Docker Build & Push') {
            environment {
                DOCKER_IMAGE = 'shettysuraksha/cicd'
                TAG = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
            }
            steps {
                script {
                    // Print current working directory
                    sh 'pwd'
                
                    // List contents of current directory
                    sh 'ls -la'
                    
                    // Build Docker image with tag
                    docker.build("${DOCKER_IMAGE}:${TAG}", '.')

                    // Push Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${TAG}").push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Print current working directory
                    sh 'pwd'
                
                    // List contents of current directory
                    sh 'ls -la'
                    
                    // Run Docker container from the built image with port mapping
                    docker.image("${DOCKER_IMAGE}:${TAG}").run('-p 9000:9000 -d')
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully executed!'
        }
    }
}
