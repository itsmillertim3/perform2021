#!/bin/bash
# This script will ensure that the bastion host is monitored through a OneAgent
# It will also install an ActiveGate as we need it for k8s monitoring

source init_helper.sh 

echo "-----------------------------------------------------------------------"
echo "Ensures this Bastion host is monitored with a OneAgent and runs an ActiveGate"
echo "-----------------------------------------------------------------------"
echo "1. Install OneAgent"
wget -O Dynatrace-OneAgent-Linux-latest.sh "https://$DT_TENANT/api/v1/deployment/installer/agent/unix/default/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $DT_PAAS_TOKEN"
sudo /bin/sh Dynatrace-OneAgent-Linux-latest.sh

echo "2. Install ActiveGate"
wget -O Dynatrace-ActiveGate-Linux-latest.sh "https://$DT_TENANT/api/v1/deployment/installer/gateway/unix/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $DT_PAAS_TOKEN"
sudo /bin/sh Dynatrace-ActiveGate-Linux-latest.sh