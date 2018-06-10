try {
             timeout(time: 20, unit: 'MINUTES') {
                def appName="mule-test"
                def project=""
                node {
                  stage("Initialize") {
                    project = env.PROJECT_NAME
                  }
                }
                node("maven") {
                  stage("Checkout") {
                    git(url: 'https://github.com/avenging/mule-test.git', branch: 'master')
                  }
                  stage("Build JAR") {
                    sh '''ls -al
mvn clean package
ls -al
ls -al target/'''
                    stash name:"jar", includes:"target/*.jar"
                  }
                }
                node {
                  stage("Build Image") {
                    unstash name:"jar"
                    sh "oc start-build mule-test --from-file=target/*.jar -n ${project}"
                    openshiftVerifyBuild bldCfg: "${appName}-docker", namespace: project, waitTime: '20', waitUnit: 'min'
                  }
                  stage("Deploy") {
                    openshiftDeploy deploymentConfig: appName, namespace: project
                  }
                }
             }
          } catch (err) {
             echo "in catch block"
             echo "Caught: ${err}"
             currentBuild.result = 'FAILURE'
             throw err
          }