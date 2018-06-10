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
                    stash name:"jar", includes:"target/hello-mule-mule-application.jar"
                  }
                }
                node {
                  stage("Build Image") {
                    unstash name:"jar"
                    sh "oc start-build mule-test --from-file=target/hello-mule-mule-application.jar -n ${project}"
                    openshiftVerifyBuild bldCfg: "mule-test", namespace: project, waitTime: '20', waitUnit: 'min'
                  }
                }
             }
          } catch (err) {
             echo "in catch block"
             echo "Caught: ${err}"
             currentBuild.result = 'FAILURE'
             throw err
          }