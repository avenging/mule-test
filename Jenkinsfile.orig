pipeline {
  agent {
    node {
      label 'maven'
    }
    
  }
  stages {
    stage('build') {
      steps {
        node(label: 'maven') {
          git(url: 'https://github.com/avenging/mule-test.git', branch: 'master')
          sh '''ls -la
mvn package'''
          stash(name: 'jar', includes: 'target/*.jar')
        }
        
      }
    }
  }
}