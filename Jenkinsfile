pipeline {
  agent any

    stages {
        stage('Build') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                mvn install -DskipTests
		"""
            }
        }
        stage('Test') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                mvn compile test"""
            }
        }
       stage('Sonar') {
            steps {
                sh """
                cd ${WORKSPACE}/boot-otel-tempo-api/
                mvn sonar:sonar
                """
            }
        }  
    }
}
