pipeline {
	environment {
AWS_REGION = "us-east-1"
AWS_REPOSITORY = "otel-demo"
AWS_ACCOUNT_ID = "785131266845"
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
		sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo docker build -t "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$AWS_REPOSITORY:$BUILD_NUMBER" .
                """    
             }
         }
  	stage('Publish image to Docker Hub') {
            steps {
		  sh """
		aws ecr get-login-password --region $AWS_REGION | docker -D login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
		docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$AWS_REPOSITORY:$BUILD_NUMBER
		track_error $? "ECR image push"
		"""
	    }
	}
	    
    }
}
