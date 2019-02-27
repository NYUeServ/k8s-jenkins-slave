pipeline {
    environment {
        registry = "mainlandhero/nyu-jenkins-slave"
        registryCredential = 'elin_dockerhub'
        dockerImageBuildNumber = ''
        dockerImageLatest = ''
    }
    agent {
        label 'master'
    }
    stages {
        stage('Clone repo') {
            steps {
                git url: 'https://github.com/NYUeServ/k8s-jenkins-slave.git'
            }
        }
        stage('Building image') {
            steps {
                script {
                    dockerImageBuildNumber = docker.build registry + ":$BUILD_NUMBER"
                    dockerImageLatest = docker.build registry + ":latest"
                }
            }
        }
        stage('Pushing image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImageBuildNumber.push()
                        dockerImageLatest.push()
                    }
                }
            }
        }
        stage('Cleaning environment') {
            steps {
                script {
                    sh "docker rmi $registry:$BUILD_NUMBER"
                    sh "docker rmi $registry:latest"
                }
            }
        }
    }
}
