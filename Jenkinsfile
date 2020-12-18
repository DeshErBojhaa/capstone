pipeline {
  agent any
  stages {
    stage('python Venv Env Setup') {
      steps {
        sh '''make setup
make install'''
        echo 'Setup Env Done'
      }
    }

    stage('lint code') {
      steps {
        sh 'echo "linting started"'
        sh 'make lint'
      }
    }

    stage('build docker image') {
      steps {
        echo 'Building docker image'
        sh 'dockerImage = docker.build registry + ":latest"'
      }
    }

    stage('push docker image') {
      steps {
        sh '''docker.withRegistry( \'\', registryCredential ) {
        dockerImage.push()
}'''
        }
      }

      stage('clean unused image') {
        steps {
          sh 'docker rmi $registry:$latest"'
        }
      }

    }
    environment {
      registry = 'desherbojhaa/udacity-predict'
      registryCredential = 'docker_credentials'
      dockerImage = ''
    }
  }