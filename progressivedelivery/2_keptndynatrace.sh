#!/bin/bash

source init_helper.sh 

echo "-----------------------------------------------------------------------"
echo "Configure Keptn - Dynatrace integration"
echo "-----------------------------------------------------------------------"

echo "1. Create the Dynatrace Secret in the keptn namespace"
kubectl create secret generic -n keptn dynatrace \
    --from-literal="DT_TENANT=$DT_TENANT" \
    --from-literal="DT_API_TOKEN=$DT_API_TOKEN" \
    --from-literal="KEPTN_API_URL=${KEPTN_ENDPOINT}/api" \
    --from-literal="KEPTN_API_TOKEN=${KEPTN_API_TOKEN}" \
    --from-literal="KEPTN_BRIDGE_URL=${KEPTN_ENDPOINT}/bridge" || true

echo "2. Make Dynatrace the default SLI provider"
kubectl create configmap lighthouse-config -n keptn --from-literal=sli-provider=dynatrace || true

echo "3. Install the dynatrace service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.10.1/deploy/service.yaml

echo "4. Install the Dynatrace SLI Service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/patch/release-0.7.1/deploy/service.yaml
