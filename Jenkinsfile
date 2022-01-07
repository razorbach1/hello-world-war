pipeline {
  agent {
    node {
      label 'docker'
    }

  }
  triggers {
   //Query repository every minute
     pollSCM('* * * * *')
  }
  stages {
    stage('checkout code') {
      steps {
        git(url: 'https://github.com/razorbach1/hello-world-war.git', branch: 'dev', changelog: true)
      }
    }

    stage('mvn compile') {
      steps {
        sh '''mvn compile
mvn clean package
'''
      }
    }

    stage('SonarQube') {
      steps {
        sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=razorbach1_hello-world-war -Dsonar.login=225ebcf7a5eb782d5be9908af75be2daaacd27f2'
      }
    }

    stage('Docker Build') {
      steps {
        sh '''echo "$USER"
docker build -t helloworld:$BUILD_ID .'''
      }
    }

    stage('push nexus') {
      steps {
        withDockerRegistry(credentialsId: 'nexus-cred', url: 'http://127.0.0.1:8123/repository/local-docker/') {
          sh '''docker tag helloworld:$BUILD_ID 127.0.0.1:8123/repository/local-docker/helloworld:$BUILD_ID
        docker push 127.0.0.1:8123/repository/local-docker/helloworld:$BUILD_ID '''
        }
      }
    }

  }
  post {
    success {
      slackSend(message: "Build deployed successfully - ${env.JOB_NAME} #${env.BUILD_NUMBER} - (${env.BUILD_URL}) ", channel: 'project-j8c7732', color: '#00FF00')
    }
	  
    failure {
      slackSend(message: " Build failed - ${env.JOB_NAME} #${env.BUILD_NUMBER} - (${env.BUILD_URL}) ", channel: 'project-j8c7732', color: '#FF0000')
    }
}
}
