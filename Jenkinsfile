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
	    steps{
		sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo docker build -t "$registry:$BUILD_NUMBER" .
                """    
             }
         }
  	stage('Publish image to Docker Hub') {
            steps {
		docker.withRegistry("$registry", "ecr:us-east-1:credential-id") {
  		docker.image("your-image-name").push()
		}
                  
          }
        }	    
	    
    }
}
