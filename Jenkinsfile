pipeline {
  agent {
    node {
      label 'docker-vm'
    }

  }
  stages {
    stage('checkout code') {
      steps {
        git(url: 'https://github.com/razorbach1/hello-world-war.git', branch: 'master', changelog: true)
      }
    }

    stage('mvn compile') {
      steps {
        sh '''mvn compile
mvn clean package
'''
      }
    }

  }
}