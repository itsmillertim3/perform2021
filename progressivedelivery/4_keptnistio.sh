#!/bin/bash
# This script will make sure we have Keptn correctly confiugred to leverage Istio

source init_helper.sh 

INGRESS_HOSTNAME=${INGRESS_HOSTNAME:-none}
INGRESS_PORT=${INGRESS_PORT:-80}
INGRESS_PROTOCOL=${INGRESS_PROTOCOL:-http}
ISTIO_GATEWAY=${KEPTN_ENDPOINT:-public-gateway.istio.system}

if [[ "$INGRESS_HOSTNAME" == "none" ]]; then
    echo "You have to set INGRESS_HOSTNAME to your Istio Ingress hostname, e.g: keptn.xxx.dynatrace.training"
    echo "You can also set INGRESS_PORT, INGRESS_PROTOCOL and ISTIO_GATEWAY. Those default to $INGRESS_PORT, $INGRESS_PROTOCOL, $ISTIO_GATEWAY"
    echo "To learn more about the required settings please visit https://keptn.sh/docs/0.7.x/continuous_delivery/expose_services/"
    exit 1
fi


echo "-----------------------------------------------------------------------"
echo "Ensure Keptns Helm Service has the correct Istio ingress information"
echo "-----------------------------------------------------------------------"
echo "1. Create ConfigMap"
kubectl create configmap -n keptn ingress-config --from-literal=ingress_hostname_suffix=${INGRESS_HOSTNAME} --from-literal=ingress_port=${INGRESS_PORT} --from-literal=ingress_protocol=${INGRESS_PROTOCOL} --from-literal=istio_gateway=${ISTIO_GATEWAY} -oyaml --dry-run | kubectl replace -f -

echo "2. Restart Helm Service"
kubectl delete pod -n keptn --selector=app.kubernetes.io/name=helm-service