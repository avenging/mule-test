pipeline {
  agent {
    node {
      label 'maven'
    }
    
  }
  stages {
    stage('build') {
      steps {
        node(label: 'jnlp') {
          sh 'mvn package'
          stash(name: 'jar', includes: 'target/*.jar')
        }
        
      }
    }
  }
}