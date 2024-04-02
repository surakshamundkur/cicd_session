pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY_CREDENTIALS = credentials('docker-hub-credentials')
    }
    
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout SCM') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/surakshamundkur/cicd_session.git']]])
            }
        }
        stage('Maven Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build and Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_REGISTRY_CREDENTIALS, url: 'https://index.docker.io/v1/']) {
                        sh 'docker build -t shettysuraksha/cicd .'
                        sh 'docker push shettysuraksha/cicd'
                    }
                }
            }
        }
        stage('Deploy to Container') {
            steps {
                sh 'docker run -d -p 9000:9000 shettysuraksha/cicd'
            }
        }
    }
}
