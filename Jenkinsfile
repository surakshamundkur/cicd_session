pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                script {
                    // Run unit tests using Maven
                    sh 'mvn test'
                }
            }
        }
        stage('Docker Build & Push') {
            environment {
                DOCKER_IMAGE = 'shettysuraksha/cicd'
                TAG = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
            }
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${TAG}", '.')
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${TAG}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
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
