#!/bin/bash
# This script will install gitea on the k8s cluster so that we can use it for our upstream git repos

source keptn_helper.sh

echo "-----------------------------------------------------------------------"
echo "Installing Gitea as Git service for our upstream git repos"
echo "-----------------------------------------------------------------------"
echo "1. Add gitea-charts to helm"
helm repo add gitea-charts https://dl.gitea.io/charts/

cd gitea
./deploy-gitea.sh $K8S_DOMAIN
cd ..

echo "-----------------------------------------------------------------------"
echo "Waiting for Gitea pods to be ready (max 5 minutes)"
echo "-----------------------------------------------------------------------"
kubectl wait --namespace=git --for=condition=Ready pods --timeout=300s --all
