pipeline {
    agent any

    tools {
        // Define Maven tool named 'maven' configured in Global Tool Configuration
        maven 'maven'
        // Define Docker tool named 'docker' configured in Global Tool Configuration
        dockerTool 'docker'
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/surakshamundkur/cicd_session.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Placeholder for running tests (if applicable)
                echo 'No tests to run'
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Build Docker image
                sh 'docker build -t shettysuraksha/cicd:latest .'

                // Push Docker image to Docker Hub
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image('shettysuraksha/cicd:latest').push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Run Docker container from the built image with port mapping using Docker command
                sh 'docker run -d -p 9000:9000 shettysuraksha/cicd:latest'
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully executed!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
