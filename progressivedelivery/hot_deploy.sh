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

KEPTN_INGRESS=$(kubectl get cm -n keptn ingress-config -ojsonpath={.data.ingress_hostname_suffix})
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)


SERVICENAME=simplenode
PROJECTNAME=$1
VERSION=$2

# keptn send event new-artifact --project=$PROJECTNAME --service=$SERVICENAME --stage=staging --image=docker.io/grabnerandi/simplenodeservice --tag=$VERSION.0.0

echo "Sending a Configuration-Changed Event via the Keptn API"
curl -X POST "http://${KEPTN_INGRESS}/api/v1/event" \
     -H "accept: application/json" \
     -H "x-token: ${KEPTN_API_TOKEN}" \
     -H "Content-Type: application/json" \
     -d "{ \"contenttype\": \"application/json\", \"data\": { \"canary\": { \"action\": \"set\", \"value\": 100 }, \"project\": \"${PROJECTNAME}\", \"service\": \"${SERVICENAME}\", \"stage\": \"staging\", \"valuesCanary\": { \"image\": \"docker.io/grabnerandi/simplenodeservice:${VERSION}.0.0\" }, \"labels\": { \"triggeredby\" : \"hot_deploy\", \"student\" : \"${PROJECTNAME}\" } }, \"source\": \"https://github.com/keptn/keptn/api\", \"specversion\": \"0.2\", \"type\": \"sh.keptn.event.configuration.change\"}"