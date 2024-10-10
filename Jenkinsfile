pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-docker-image-nam' // Replace with your Docker image name
        DOCKER_TAG = 'latest' // Tag for the Docker image
        GIT_REPO = 'https://github.com/prasaisushant/CI-CD-test.git' // Update to your GitHub repository
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Automatically pulls the latest code from the specified branch
                git branch: 'main', url: "${GIT_REPO}" // Update branch if necessary
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repository
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub using credentials stored in Jenkins
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    
                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up unused Docker images
            sh 'docker image prune -f'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
