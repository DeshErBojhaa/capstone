pipeline {
  agent any
  stages {
    stage('lint code') {
      steps {
        sh 'echo "linting started"'
        sh 'make install'
        sh 'ls -la'
        sh 'pwd'
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