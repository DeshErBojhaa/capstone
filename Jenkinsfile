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
          sh 'echo "Dummy Build"'
          // sh 'docker build -t desherbojhaa/udacity-predict .'
        }
      }
    }
    
    stage('Upload Docker Image to Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOC_USERNAME', passwordVariable: 'DOC_PASSWORD')]) {
          // sh '''
          //   docker login -u $DOC_USERNAME -p $DOC_PASSWORD
          //   docker push desherbojhaa/udacity-predict
          //   '''
          sh 'echo "Dummy push"'
        }
      }
    }

    stage('clean unused image') {
      steps {
        // sh 'docker rmi $registry'
        sh 'echo "Dummy Delete"'
      }
    }
    stage('Added New kubectl Context') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
					    aws eks --region us-west-2 update-kubeconfig --name capstone
					'''
				}
			}
		}
    
    stage('Set Current kubectl Context') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
					    kubectl config use-context arn:aws:eks:us-west-2:639361319097:cluster/capstone
					'''
				}
			}
		}

    stage('Deploy Blue Container') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
            whoami
            ls -la ./
						kubectl apply -f ./deploy/blue-controller.yml -v=8
					'''
				}
			}
		}
		stage('Deploy Green Container') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/green-controller.yml -v=8
					'''
				}
			}
		}
    stage('Create Service in the Cluster-Blue') {
			steps {
				withAWS(region:'us-west-2', credentials:'aws_id') {
					sh '''
						kubectl apply -f ./deploy/blue-lb-service.yml
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
						kubectl apply -f ./deploy/green-lb-service.yml
					'''
				}
			}
		}
  }
}