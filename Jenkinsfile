pipeline {
  agent {
    node {
      label 'dockerS'
    }

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

    stage('Push Nexus') {
      steps {
        sh '''docker tag helloworld:$BUILD_ID 127.0.0.1:8123/repository/local-docker/helloworld:$BUILD_ID
docker push 127.0.0.1:8123/repository/local-docker/helloworld:$BUILD_ID'''
      }
    }

  }
}