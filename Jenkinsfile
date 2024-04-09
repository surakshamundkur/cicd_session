pipeline {
    agent any

    tools {
        maven 'maven' // Define Maven tool named 'maven' to be used in the pipeline
        dockerTool 'docker' // Define Docker tool named 'docker' to be used in the pipeline
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout source code from Git repository
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/surakshamundkur/cicd_session.git']]])
            }
        }

        stage('Maven Build') {
            steps {
                // Clean and package the Java project using Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
                // Run unit and integration tests using Maven
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Build Docker image with a specific tag
                sh 'docker build -t shettysuraksha/cicd:latest .'

                script {
                    // Push the Docker image to a Docker registry (e.g., Docker Hub)
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image('shettysuraksha/cicd:latest').push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Find and stop existing container(s) running on port 9000
                sh 'docker ps -q --filter "publish=9000" | xargs -r docker stop'

                // Run Docker container from the built image with port mapping
                sh 'docker run -d -p 9000:9000 shettysuraksha/cicd:latest'
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully executed!' // Display success message if pipeline completes successfully
        }
        failure {
            echo 'Pipeline failed!' // Display failure message if pipeline fails
        }
    }
}