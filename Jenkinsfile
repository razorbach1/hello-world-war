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
        withSonarQubeEnv(credentialsId: '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', envOnly: true, installationName: 'SonaeQube-server') {
          waitForQualityGate(abortPipeline: true, credentialsId: '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')
        }

      }
    }

  }
}