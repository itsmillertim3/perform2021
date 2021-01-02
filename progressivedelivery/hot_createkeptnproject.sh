#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify a project name!"
  echo "Usage: $0 student001"
  exit 1
fi

SERVICENAME=simplenode
PROJECTNAME=$1

echo "Create Keptn Project: ${PROJECTNAME}"
keptn create project "${PROJECTNAME}" --shipyard=${SERVICENAME}/shipyard.yaml

echo "Onboard Service ${SERVICENAME} to Project: ${PROJECTNAME}"
keptn onboard service ${SERVICENAME} --project="${PROJECTNAME}" --chart=simplenode/charts

echo "Adding JMeter files"
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx

echo "Adding SLO file"
keptn add-resource --project="${PROJECTNAME}" --service=${SERVICENAME} --stage=staging --resource=${SERVICENAME}/slo.yaml --resourceUri=slo.yaml
keptn add-resource --project="${PROJECTNAME}" --service=${SERVICENAME} --stage=prod --resource=${SERVICENAME}/slo.yaml --resourceUri=slo.yaml

echo "Enable Namespaces Labels & Annotations to be accessible by Dynatrace OneAgent"
# https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/other-deployments-and-configurations/leverage-tags-defined-in-kubernetes-deployments/
kubectl create namespace ${PROJECTNAME}-staging
kubectl create namespace ${PROJECTNAME}-prod
kubectl -n ${PROJECTNAME}-staging create rolebinding default-view --clusterrole=view --serviceaccount=${PROJECTNAME}-staging:default
kubectl -n ${PROJECTNAME}-prod create rolebinding default-view --clusterrole=view --serviceaccount=${PROJECTNAME}-prod:default