#!/bin/bash
# This script will install all dynatrace relevant keptn services, e.g: dynatrace, dynatrace-sli, monaco ..
# It also configures the Dynatrace credentials via the secret and sets dynatrace-sli as the default SLI provider

source init_helper.sh 

# Initialize versions
KEPTN_VERSION="0.7.3"


echo "-----------------------------------------------------------------------"
echo "Install Istio"
echo "-----------------------------------------------------------------------"

istioctl install -y

# get the ingress_host
INGRESS_HOST=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "-----------------------------------------------------------------------"
echo "Install Keptn"
echo "-----------------------------------------------------------------------"
helm upgrade keptn keptn --install -n keptn --create-namespace --wait --version=${KEPTN_VERSION} --repo=https://storage.googleapis.com/keptn-installer --set=continuous-delivery.enabled=true

echo "-----------------------------------------------------------------------"
echo "Waiting for Keptn pods to be ready (max 5 minutes)"
echo "-----------------------------------------------------------------------"
kubectl wait --namespace=keptn --for=condition=Ready pods --timeout=300s --all

echo "-----------------------------------------------------------------------"
echo "Finish Keptn/Istio Configuration"
echo "-----------------------------------------------------------------------"
source keptn_helper.sh

echo "-----------------------------------------------------------------------"
echo "Exposes the Keptn Bridge via Istio Ingress: $KEPTN_INGRESS_HOSTNAME"
echo "-----------------------------------------------------------------------"
cat ./keptn/keptn-ingress.yaml | sed 's~domain.placeholder~'"$K8S_DOMAIN"'~' > ./keptn/gen/keptn-ingress.yaml
kubectl apply -f ./keptn/gen/keptn-ingress.yaml

echo "-----------------------------------------------------------------------"
echo "Ensure Keptns Helm Service has the correct Istio ingress information: $KEPTN_INGRESS_HOSTNAME"
echo "-----------------------------------------------------------------------"
echo "1. Create ConfigMap"
kubectl create configmap -n keptn ingress-config --from-literal=ingress_hostname_suffix=${KEPTN_INGRESS_HOSTNAME} --from-literal=ingress_port=${INGRESS_PORT} --from-literal=ingress_protocol=${INGRESS_PROTOCOL} --from-literal=istio_gateway=${ISTIO_GATEWAY} -oyaml --dry-run | kubectl replace -f -

echo "2. Restart Helm Service"
kubectl delete pod -n keptn --selector=app.kubernetes.io/name=helm-service


echo "-----------------------------------------------------------------------"
echo "Install & Configure Keptn Dynatrace integration"
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

echo "5. Enable Label & Annotation monitoring of key namespaces"
kubectl -n keptn create rolebinding default-view --clusterrole=view --serviceaccount=keptn:default
kubectl -n istio-system create rolebinding default-view --clusterrole=view --serviceaccount=istio-system:default

echo "6. Install Dynatrace Monaco Keptn Service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-sandbox/monaco-service/release-0.2.0/deploy/service.yaml

echo "7. Authenticate Keptn CLI"
keptn auth  --api-token "${KEPTN_API_TOKEN}" --endpoint "${KEPTN_ENDPOINT/api"
