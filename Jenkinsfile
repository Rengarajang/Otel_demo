pipeline {
	environment {
        registry = "785131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo"
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
    stage('Test') {
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
        }   
	stage('Building image') {
      	  steps {
        	script {
          	dockerImage = docker.build registry + ":$BUILD_NUMBER"
        	}
      		}
   	 }
	stage('Push Image') {
     	  steps {   
		
		sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 785131266845.dkr.ecr.us-east-1.amazonaws.com"
		sh "docker push 785131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo:$BUILD_NUMBER"         
	    }
        }  
  
	    
    }
}
