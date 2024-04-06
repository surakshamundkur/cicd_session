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
