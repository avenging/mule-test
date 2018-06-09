pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        openshiftBuild(namespace: 'mule-test', bldCfg: 'mule-test', showBuildLogs: 'true')
      }
    }
  }
}