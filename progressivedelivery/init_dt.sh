#!/bin/bash

DT_TENANT=${DT_TENANT:-none}
DT_API_TOKEN=${DT_API_TOKEN:-none}
KEPTN_ENDPOINT=${KEPTN_ENDPOINT:-none}
KEPTN_API_TOKEN=${KEPTN_API_TOKEN:-none}

if [[ "$DT_TENANT" == "none" ]]; then
    echo "You have to set DT_TENANT to your Tenant URL, e.g: abc12345.dynatrace.live.com or yourdynatracemanaged.com/e/abcde-123123-asdfa-1231231"
    echo "To learn more about the required settings please visit https://keptn.sh/docs/0.7.x/monitoring/dynatrace/install"
    exit 1
fi
if [[ "$DT_API_TOKEN" == "none" ]]; then
    echo "You have to set DT_API_TOKEN to a Token that has read/write configuration, access metrics, log content and capture request data priviliges"
    echo "If you want to learn more please visit https://keptn.sh/docs/0.7.x/monitoring/dynatrace/install"
    exit 1
fi
if [[ "$KEPTN_ENDPOINT" == "none" ]]; then
    echo "You have to set KEPTN_ENDPOINT to your Keptn Endpoint, e.g: http://yourkeptndomain.abc.com"
    exit 1
fi
if [[ "$KEPTN_API_TOKEN" == "none" ]]; then
    echo "You have to set KEPTN_API_TOKEN to the Keptn API like shown here"
    echo "KEPTN_API_TOKEN=\$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)"
    exit 1
fi

echo "Create the Dynatrace Secret in the keptn namespace"
kubectl create secret generic -n keptn dynatrace \
    --from-literal="DT_TENANT=$DT_TENANT" \
    --from-literal="DT_API_TOKEN=$DT_API_TOKEN" \
    --from-literal="KEPTN_API_URL=${KEPTN_ENDPOINT}/api" \
    --from-literal="KEPTN_API_TOKEN=${KEPTN_API_TOKEN}" \
    --from-literal="KEPTN_BRIDGE_URL=${KEPTN_ENDPOINT}/bridge" || true

echo "Make Dynatrace the default SLI provider"
kubectl create configmap lighthouse-config -n keptn --from-literal=sli-provider=dynatrace || true

echo "Install the dynatrace service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.10.1/deploy/service.yaml

echo "Install the Dynatrace SLI Service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/patch/release-0.7.1/deploy/service.yaml