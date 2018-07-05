Mule ESB Build Deploy Pipeline and Promotion Example
====================================================

This is an example of building up a mule ESB application deployment as a container using
* Openshift
* Openshift/Jenkins Pipeline

Then promoting a resultant images to another environment. It also shows the use of configmaps to change
the output of the mule application in different environments

Prerequisites
=============

A working Openshift installation (possibly works in minishift) with at least 4GB or RAM free.

Setup
=============

Create 2 projects within openshift

* oc login (login as a user)
* oc new-project mule-dev
* oc new-project mule-uat

Make sure you are intially using the mule-dev project

* oc project mule-dev

Creation of openshift config
-------------

Within the mule-dev project run these commands:

Create image streams:
* oc create -f imageStream.yml -f imageStream-mule.yml -f imageStream-mule-helloworld.yml

Create build configs:
* oc create -f mule-buildconfig.yml -f mule-helloworld-buildconfig.yml

Create Deployment:
* oc create -f mule-deployment.yml

Create Service:
* oc create -f mule-service.yml

Create configmap for Dev:
* oc create -f mule-dev-configmap.yml

Then run this script:
* ./set-uat-policy.sh

Once deployed you may wish to create a route to the mule app to test output or you can use curl locally on the openshift host
running the container

Within the mule-uat project run these commands:

Create Deployment:
* oc create -f mule-uat-deployment.yml

Create Service:
* oc create -f mule-uat-service.yml

Create Confimap:
* oc create -f mule-uat-configmap.yml

Basic configuration is done. Now we need to create the Jenkins instance and pipeline. Back in the mule-dev project run:
* oc create -f mule-build-pipeline.yml

Thie will create a Jenkins instance in the project and start it up ready for the pipeline build of the Mule application.

Building the inital Mule container
-------------

We need to build the inital Mule container that will be used for the application before we kick off the Jenkins pipeline.
In the mule-dev project run
* oc start-build mule-test

Building the App using the Jenkins Pipeline
-------------

Next run the Jenkins Pipeline
* oc start-build mule-dev-pipeline

Once this is complete the Deployment for the app should run and you will have Mule container running the HelloWorld App.
Create a route to the service
* oc expose service mule-helloworld
* oc get route mule-helloworld

If you go to the URL or do a curl request you should get
"dev environment"

The app is displaying the content of the mule-dev-ocnfigmap. You can change the configmap and it will replace what is displayed
* oc patch configmap mule-configmap -p '{"data":{"message": "Hello World" }}'

You may have to wait a little while as openshift does the changeover to the configmap

Promoting the container into the UAT environment
--------------

Now we are happy with our wonderful new Mule app it's time to promote it. Run the promote script:
* ./promote-to-uat.sh

Switch to the mule-uat project:
* oc project mule-uat

Expose a route to the Container in UAT
* oc expose service mule-helloworld
* oc get route mule-helloworld

Go the the URL and the App will output "uat environment" 
