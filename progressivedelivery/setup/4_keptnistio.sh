#!/bin/bash
# This script will make sure we have Keptn correctly confiugred to leverage Istio

source init_helper.sh 

K8S_DOMAIN=${K8S_DOMAIN:-none}
INGRESS_PORT=${INGRESS_PORT:-80}
INGRESS_PROTOCOL=${INGRESS_PROTOCOL:-http}
ISTIO_GATEWAY=${KEPTN_ENDPOINT:-public-gateway.istio.system}

if [[ "$K8S_DOMAIN" == "none" ]]; then
    echo "You have to set K8S_DOMAIN to your Istio Ingress domain, e.g: xxx.dynatrace.training"
    echo "You can also set INGRESS_PORT, INGRESS_PROTOCOL and ISTIO_GATEWAY. Those default to $INGRESS_PORT, $INGRESS_PROTOCOL, $ISTIO_GATEWAY"
    echo "To learn more about the required settings please visit https://keptn.sh/docs/0.7.x/continuous_delivery/expose_services/"
    exit 1
fi

KEPTN_INGRESS_HOSTNAME="keptn.$K8S_DOMAIN"

echo "-----------------------------------------------------------------------"
echo "Ensure Keptns Helm Service has the correct Istio ingress information: $KEPTN_INGRESS_HOSTNAME"
echo "-----------------------------------------------------------------------"
echo "1. Create ConfigMap"
kubectl create configmap -n keptn ingress-config --from-literal=ingress_hostname_suffix=${KEPTN_INGRESS_HOSTNAME} --from-literal=ingress_port=${INGRESS_PORT} --from-literal=ingress_protocol=${INGRESS_PROTOCOL} --from-literal=istio_gateway=${ISTIO_GATEWAY} -oyaml --dry-run | kubectl replace -f -

echo "2. Restart Helm Service"
kubectl delete pod -n keptn --selector=app.kubernetes.io/name=helm-service