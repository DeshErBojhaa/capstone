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

    stage('Build Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOC_USERNAME', passwordVariable: 'DOC_PASSWORD')]) {
          sh 'echo $DOC_USERNAME  $DOC_PASSWORD'
          sh 'docker build -t desherbojhaa/udacity-predict .'
        }
      }
    }
    
    stage('Upload Docker Image to Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOC_USERNAME', passwordVariable: 'DOC_PASSWORD')]) {
          sh '''
            docker login -u $DOC_USERNAME -p $DOC_PASSWORD
            docker push desherbojhaa/udacity-predict
            '''
        }
      }
    }

      stage('clean unused image') {
        steps {
          sh 'docker rmi $registry'
        }
      }

    }
    environment {
      registry = 'desherbojhaa/udacity-predict'
      registryCredential = 'dockerhub_id'
      dockerImage = ''
    }
  }