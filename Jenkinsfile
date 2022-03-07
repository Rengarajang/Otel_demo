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
		sh 'cd ${WORKSPACE}/boot-otel-tempo-api/'
        	script {
          	/*dockerImage = docker.build registry + ":$BUILD_NUMBER" */
		dockerImage = docker.build registry + ":latest"	
        	}
      		}
   	 }
	stage('Push Image') {
     	  steps {   
		
		sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 785131266845.dkr.ecr.us-east-1.amazonaws.com"
		sh "docker push 785131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo:latest"         
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
	  sh 'sudo docker run -d --privileged --pid=host --network otel_demo_default -p 9095:8080 -e PROVIDER1_URL_BASE=http://172.31.6.50:8090 -v /var/jenkins_home/logs:/app/logs --name otel-api 785131266845.dkr.ecr.us-east-1.amazonaws.com/otel-demo' 
	   }
	}

	 
	    
    }
}
