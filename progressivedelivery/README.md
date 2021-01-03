# Welcome to Progressive Delivery & Release Management HOTWEEK

This repository contains 3 major assets

## 1: CodeLab instructions

As you are going to run throug this HOT (Hands-On-Training) you will walk through the instructions on Dynatrace University powered by CodeLab!
The markdown for CodeLab and the images can be found in the content and assets folders!

## 2: Setup Scripts (trainers only)

This HOT requires
1. A k8s cluster 
1. Installed Keptn 0.7.3 for Continuous Delivery
1. Installed Istio
1. A Dynatrace Tenant
1. A Bastion Host to access k8s & keptn

Additional installation steps are necessary to e.g: monitor k8s with Dynatrace, install Dynatrace-Keptn services, ...
These scripts can be found in the root folder of this repository. They are all prefixed with a number starting with 0_xxx.sh

These scripts ARE ONLY TO BE EXECUTED by the trainers or the Dynatrace University admins!

## 3: Hands-On Tutorial Scripts

For some of the Hands on Tutorials the trainees need to e.g: deploy a new version of a microservice.
To make this easier we have created a set of scripts that are prefixed with hot_xxx.sh