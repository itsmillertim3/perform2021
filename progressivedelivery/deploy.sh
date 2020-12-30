#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify a project name!"
  echo "Usage: $0 student001 1"
  exit 1
fi

if [[ -z "$2" ]]; then
  echo "You have to specify a version to deply!"
  echo "Usage: $0 student001 1"
  exit 1
fi

SERVICENAME=simplenode
PROJECTNAME=$1
VERSION=$2

keptn send event new-artifact --project=$PROJECTNAME --service=$SERVICENAME --image=docker.io/grabnerandi/simplenodeservice --tag=$VERSION.0.0