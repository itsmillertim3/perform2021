#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify a project name, e.g: studentxxx"
  echo "Usage: $0 student001"
  exit 1
fi

SERVICENAME=simplenode
STAGE_PROD=prod
STAGE_STAGING=staging
PROJECTNAME=$1

echo "Create Keptn Project: ${PROJECTNAME} based on shipyard.yaml"
keptn create project "${PROJECTNAME}" --shipyard=${SERVICENAME}/shipyard.yaml

echo "Onboard Service ${SERVICENAME} to Project: ${PROJECTNAME} using simplenode/charts"
keptn onboard service ${SERVICENAME} --project="${PROJECTNAME}" --chart=simplenode/charts

echo "Adding JMeter files on project level"
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx

echo "Adding dynatrace.conf.yaml on project level"
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/dynatrace/dynatrace.conf.yaml --resourceUri=dynatrace/dynatrace.conf.yaml
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/dynatrace/monaco.conf.yaml --resourceUri=dynatrace/monaco.conf.yaml

echo "Adding SLO files for staging & prod"
keptn add-resource --project="${PROJECTNAME}" --service=${SERVICENAME} --stage=${STAGE_STAGING} --resource=${SERVICENAME}/slo.yaml --resourceUri=slo.yaml
keptn add-resource --project="${PROJECTNAME}" --service=${SERVICENAME} --stage=${STAGE_PROD} --resource=${SERVICENAME}/slo.yaml --resourceUri=slo.yaml

echo "Add monaco configuration for setting up Synthetic Tests"
# If we havent yet prepared the synthetic.yaml we do it now by replacing REPLACE_KEPTN_INGRESS with the actual KEPTN_INGRESS.
if [ ! -f simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml ]; then
  KEPTN_INGRESS=$(kubectl get cm -n keptn ingress-config -ojsonpath={.data.ingress_hostname_suffix})
  sed "s/REPLACE_KEPTN_INGRESS/$KEPTN_INGRESS/g" simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml.tmpl >> simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml
fi 

keptn add-resource --project="${PROJECTNAME}" --service="${SERVICENAME}" --stage="${STAGE_PROD}" --resource=simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml --resourceUri=dynatrace/projects/${SERVICENAME}/synthetic-monitor/synthetic.yaml
keptn add-resource --project="${PROJECTNAME}" --service="${SERVICENAME}" --stage="${STAGE_PROD}" --resource=simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.json --resourceUri=dynatrace/projects/${SERVICENAME}/synthetic-monitor/synthetic.json

echo "Enable Namespaces Labels & Annotations to be accessible by Dynatrace OneAgent"
# https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/other-deployments-and-configurations/leverage-tags-defined-in-kubernetes-deployments/
kubectl -n ${PROJECTNAME}-${STAGE_STAGING} create rolebinding default-view --clusterrole=view --serviceaccount=${PROJECTNAME}-${STAGE_STAGING}:default
kubectl -n ${PROJECTNAME}-${STAGE_PROD} create rolebinding default-view --clusterrole=view --serviceaccount=${PROJECTNAME}-${STAGE_PROD}:default

echo "TODO: Create Dynatrace SLOs for service in production"

echo "Creating a Git Repository for this project"
cd setup/gitea
./create-upstream-git.sh ${PROJECTNAME}
cd ../..