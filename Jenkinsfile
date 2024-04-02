pipeline {
    agent any
    tools {
        jdk 'jdk11'
        maven 'maven3'
    }
    stages {
        stage ('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage ('Checkout SCM') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/surakshamundkur/cicd_session.git']]])
            }
        }
        stage ('Maven Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage ('OWASP Dependency Check') {
            steps {
                script {
                    dependencyCheck additionalArguments: '--scan ./ --format HTML ', odcInstallation: 'DP-Check'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }
        stage ('Build War File') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage ('Build and Push to Docker Hub') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t shettysuraksha/cicd ."
                        sh "docker push shettysuraksha/cicd:latest"
                    }
                }
            }
        }
        stage ('Deploy to Container') {
            steps {
                sh 'docker run -d --name pet1 -p 9000:9000 shettysuraksha/cicd:latest'
            }
        }
    }
}
