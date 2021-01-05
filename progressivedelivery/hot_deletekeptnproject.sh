#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify a project name, e.g: studentxxx"
  echo "Usage: $0 student001"
  exit 1
fi

STAGE_PROD=prod
STAGE_STAGING=staging
PROJECTNAME=$1

echo "Delete Keptn Project: ${PROJECTNAME}"
keptn delete project ${PROJECTNAME}

echo "Deleting namespaces for staging & prod"
kubectl delete ns "${PROJECTNAME}-staging"
kubectl delete ns "${PROJECTNAME}-prod"
