pipeline {
	environment {
        accountId = "785131266845"
	ec2PrivateIP="172.31.76.146"
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
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                sudo docker build -t ${accountId}.dkr.ecr.us-east-1.amazonaws.com/otel-demo:latest .
                """
      		}
   	 }
	stage('Push Image') {
     	  steps {   
		  sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${accountId}.dkr.ecr.us-east-1.amazonaws.com"
		  sh "docker push ${accountId}.dkr.ecr.us-east-1.amazonaws.com/otel-demo:latest"     
	    }
        }  
	stage('stop previous containers') {
         steps {
            sh 'docker ps -a -f name=otel-api -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=otel-api -q | xargs -r docker container rm'
         }
       } 
	
	stage('deploy App') {
         steps {	    
	  sh 'sudo docker run -d --privileged --pid=host --network otel_demo_default -p 9095:8080 -e PROVIDER1_URL_BASE=http://${ec2PrivateIP}:8090 --name otel-api ${accountId}.dkr.ecr.us-east-1.amazonaws.com/otel-demo' 
	   }
	}

	 
	    
    }
}
