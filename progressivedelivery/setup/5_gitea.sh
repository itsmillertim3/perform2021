#!/bin/bash
# This script will install gitea on the k8s cluster so that we can use it for our upstream git repos

source init_helper.sh 

K8S_DOMAIN=${K8S_DOMAIN:-none}

echo "-----------------------------------------------------------------------"
echo "Installing Gitea as Git service for our upstream git repos"
echo "-----------------------------------------------------------------------"
echo "1. Add gitea-charts to helm"
helm repo add gitea-charts https://dl.gitea.io/charts/

cd gitea
./deploy-gitea.sh $K8S_DOMAIN
cd ..
