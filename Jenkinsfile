pipeline {
    agent any

    tools {
        maven 'maven'
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
                sh 'mvn test'
                //erun unit and integration tests
            }
        }

        stage('Docker Build & Push') {
            steps {
                sh 'docker build -t shettysuraksha/cicd:latest .'

                script {
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
            echo 'Pipeline successfully executed!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}