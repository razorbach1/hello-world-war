pipeline {
  agent {
    node {
      label 'docker-vm'
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
        sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=razorbach1_hello-world-war -Dsonar.login=8b88802f2dd267bdf32f87219cbabafb11d3ff3d'
      }
    }

  }
}