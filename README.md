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
* oc create-project mule-dev
* oc create-project mule-uat

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
mule-uat-configmap.yml

Basic configuration is done. Now we need to create the Jenkins instance and pipeline. Back in the mule-dev project run:
* oc create -f mule-build-pipeline.yml

Thie will create a Jenkins instance in the project and start it up ready for the pipeline build of the Mule application.

Building the inital Mule container
-------------

We need to build the inital Mule container that will be used for the application before we kick off the Jenkins pipeline.
In the mule-dev project run
oc 



