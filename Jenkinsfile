pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        node(label: 'maven') {
          sh 'mvn package'
          stash(name: 'jar', includes: 'target/*.jar')
        }
        
      }
    }
  }
}