pipeline {
	environment {
        registry = "85131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo"
        registryCredential = 'aws-access'
        dockerImage = ''
	}	
	
  agent any

    stages {
        stage('Build') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo mvn clean install -DskipTests
		"""
            }
        }
 /**    stage('Test') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo mvn compile test"""
            }
        } 
       stage('Sonar') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo mvn sonar:sonar
                """
            }
        }   **/
	stage('Building image') {
      	  steps{
        	script {
          	dockerImage = docker.build registry
            	docker.build('otel-demo')
        	}
      		}
   	 }
	stage('Push Image to ECR') {
     	  steps{   
         	script {
		sh 'aws ecr get-login-password --region us-east-1 | docker -D login --username AWS --password-stdin 85131266845.dkr.ecr.us-east-1.amazonaws.com'
		sh 'docker push 85131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo:$BUILD_NUMBER'
            }
        }
      }
	    
    }
}
