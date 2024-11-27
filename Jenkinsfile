pipeline {
  environment {
    registry = "sushant60/cicdtest"
    registryCredential = 'docker_id' // Docker Hub credentials set in Jenkins
    dockerImage = ''
  }
  agent none // Do not assign a global agent; define it per stage
  stages {
    stage('Cloning our Git') {
      agent {
        label 'docker' // Run on the docker agent
      }
      steps {
        git url: 'https://github.com/prasaisushant/CI-CD-test.git', branch: 'main'
      }
    }
    stage('Building our image') {
      agent {
        label 'docker' // Run on the docker agent
      }
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy our image') {
      agent {
        label 'docker' // Run on the docker agent
      }
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Run Ansible Playbook') {
      agent {
        label 'ansible' // Run on the ansible agent
      }
      steps {
        script {
          // Use the Docker image tag in the Ansible playbook execution
          sh "ansible-playbook -i /playbooks/hosts /playbooks/update.yml -e new_image=${registry}:${BUILD_NUMBER}"
        }
      }
    }
    stage('Cleaning up') {
      agent {
        label 'docker' // Run on the docker agent
      }
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
