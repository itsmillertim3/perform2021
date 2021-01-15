#!/bin/bash
# This script will 
# * Install all necessary tools such as Helm, Istio and Keptn CLI
# * ensure that the bastion host is monitored through a OneAgent
# * install an ActiveGate as we need it for k8s monitoring
#
# It requires the following ENV-Variables to be set!


# Initialize versions
HELM_VERSION="3.3.0"
ISTIO_VERSION="1.7.3"

echo "-----------------------------------------------------------------------"
echo "Ensures this Bastion host has all recommended tools: git, kubectl, curl, ..."
echo "-----------------------------------------------------------------------"

if ! [ -x "$(command -v kubectl)" ]; then
  echo 'Error: kubectl must be installed and connected to your k8s cluster.' >&2
  exit 1
fi

sudo apt install curl
sudo apt install wget

source init_helper.sh 


echo "-----------------------------------------------------------------------"
echo "Ensures this Bastion host is monitored with a OneAgent and runs an ActiveGate"
echo "-----------------------------------------------------------------------"
echo "1. Install OneAgent"
wget -O Dynatrace-OneAgent-Linux-latest.sh "https://$DT_TENANT/api/v1/deployment/installer/agent/unix/default/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $DT_PAAS_TOKEN"
sudo /bin/sh Dynatrace-OneAgent-Linux-latest.sh --set-host-name=bastionhost

echo "2. Install ActiveGate"
wget -O Dynatrace-ActiveGate-Linux-latest.sh "https://$DT_TENANT/api/v1/deployment/installer/gateway/unix/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $DT_PAAS_TOKEN"
sudo /bin/sh Dynatrace-ActiveGate-Linux-latest.sh

echo "3. Make sure zip is installed"
sudo apt install zip

echo "4. Make sure a JRE is installed"
sudo apt install default-jre -y


echo "-----------------------------------------------------------------------"
echo "Download Helm, Istio & Keptn CLI"
echo "-----------------------------------------------------------------------"
echo "1. Download Helm"
wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

echo "2. Keptn CLI Helm"
curl -sL https://get.keptn.sh | sudo -E bash

echo "3. Download Install Istio"
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -
sudo mv istio-${ISTIO_VERSION}/bin/istioctl /usr/local/bin/istioctl

istioctl install -y

# get the ingress_host
INGRESS_HOST=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "-----------------------------------------------------------------------"
echo "MANUAL STEP REQUIRED BEFORE CONTINUE"
echo "-----------------------------------------------------------------------"
echo "1. Setup wildcard DNS, e.g: *.dtu-perform-s26.dynatrace.training for Istio-Ingress: $INGRESS_HOST"
echo "2. Then export K8S_DOMAIN=dtu-perform.s26.dynatrace.training"
echo "3. Continue running the rest of the installation scripts"

