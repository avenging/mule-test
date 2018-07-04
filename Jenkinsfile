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
                    stash name:"zip", includes:"target/hello-mule.zip"
                  }
                }
                node {
                  stage("Build Image") {
                    unstash name:"zip"
                    sh "oc start-build mule-helloworld --from-file=target/hello-mule.zip -n ${project}"
                    openshiftVerifyBuild bldCfg: "mule-helloworld", namespace: project, waitTime: '20', waitUnit: 'min'
                  }
                }
             }
          } catch (err) {
             echo "in catch block"
             echo "Caught: ${err}"
             currentBuild.result = 'FAILURE'
             throw err
          }
