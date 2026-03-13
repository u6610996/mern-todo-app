pipeline {
    agent any

    environment {
        IMAGE_NAME = "u6610996/finead-todo-app:latest"
    }

    stages {

        stage('Build') {
            steps {
                echo 'Installing dependencies...'
                dir('TODO/todo_frontend') {
                    sh 'npm install'
                }
                dir('TODO/todo_backend') {
                    sh 'npm install'
                }
            }
        }

        stage('Containerise') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Push') {
            steps {
                echo 'Pushing to Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push ${IMAGE_NAME}'
                }
            }
        }

        stage('Deploy Info') {
            steps {
                echo "Image pushed: ${IMAGE_NAME}"
                echo 'Pipeline complete!'
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}