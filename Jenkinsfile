pipeline {
  agent any
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
        sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=razorbach1_hello-world-war -Dsonar.login=$sonar_cerd'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t helloworld:$BUILD_ID .'
      }
    }

    stage('Push Nexus') {
      steps {
        sh 'docker tag helloworld:$BUILD_ID 3.10.161.70:8123/repository/local-docker//helloworld:$BUILD_ID'
      }
    }

  }
}