#!/bin/bash
# This script initializes a couple of important env-variables for istio & keptn

# INGRESS_HOST=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
K8S_DOMAIN=${K8S_DOMAIN:-none}
INGRESS_PORT=${INGRESS_PORT:-80}
INGRESS_PROTOCOL=${INGRESS_PROTOCOL:-http}
ISTIO_GATEWAY=${ISTIO_GATEWAY:-public-gateway.istio.system}

if [[ "$K8S_DOMAIN" == "none" ]]; then
    echo "Couldnt get istio-ingressgateway to retrieve ingress hostname!"
    echo "We need this to expose Keptn services. For more information visit: https://keptn.sh/docs/0.7.x/continuous_delivery/expose_services/"
    exit 1
fi

KEPTN_INGRESS_HOSTNAME="keptn.$K8S_DOMAIN"
KEPTN_ENDPOINT="http://$KEPTN_INGRESS_HOSTNAME"
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
BRIDGE_USERNAME=$(kubectl get secret bridge-credentials -n keptn -o jsonpath={.data.BASIC_AUTH_USERNAME} | base64 -d)
BRIDGE_PASSWORD=$(kubectl get secret bridge-credentials -n keptn -o jsonpath={.data.BASIC_AUTH_PASSWORD} | base64 -d)

GIT_USER="keptn"
GIT_PASSWORD="keptn#R0cks"
GIT_SERVER="http://git.$K8S_DOMAIN"