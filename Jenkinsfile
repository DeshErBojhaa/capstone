pipeline {
  environment {
    registry = 'desherbojhaa/udacity-predict'
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Install dependencies') {
      steps {
        sh 'make install'
      }
    }
    stage('lint code') {
      steps {
        sh 'echo "linting started"'
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

    stage('Deploy Blue Container') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/blue-controller.json
					'''
				}
			}
		}
		stage('Deploy Green Container') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/green-controller.json
					'''
				}
			}
		}
    stage('Create Service in the Cluster-Blue') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/blue-lb-service.json
					'''
				}
			}
		}
		stage('Wait for User Permission') {
      steps {
        input "Do you want to redirect traffic to green?"
      }
    }
    stage('Create Service in the Cluster-Green') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/green-lb-service.json
					'''
				}
			}
		}
  }
}