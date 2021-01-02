#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify a project name and a version. Available versions are 1, 2,3 or 4!"
  echo "Usage: $0 student001 1"
  exit 1
fi

if [[ -z "$2" ]]; then
  echo "You have to specify a version to deploy! Available versions are 1, 2,3 or 4!"
  echo "Usage: $0 student001 1"
  exit 1
fi

SERVICENAME=simplenode
PROJECTNAME=$1
VERSION=$2

keptn send event new-artifact --project=$PROJECTNAME --service=$SERVICENAME --image=docker.io/grabnerandi/simplenodeservice --tag=$VERSION.0.0