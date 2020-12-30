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
keptn onboard service ${SERVICENAME} --project="${PROJECTNAME}"

echo "Adding JMeter files"
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project="${PROJECTNAME}" --resource=${SERVICENAME}/jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx

