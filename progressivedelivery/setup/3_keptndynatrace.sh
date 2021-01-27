#!/bin/bash
# This script will install all dynatrace relevant keptn services, e.g: dynatrace, dynatrace-sli, monaco ..
# It also configures the Dynatrace credentials via the secret and sets dynatrace-sli as the default SLI provider

source init_helper.sh 

# Initialize versions
KEPTN_VERSION="0.7.3"

echo "-----------------------------------------------------------------------"
echo "Install Keptn"
echo "-----------------------------------------------------------------------"
# helm upgrade keptn keptn --install -n keptn --create-namespace --wait --version=${KEPTN_VERSION} --repo=https://storage.googleapis.com/keptn-installer --set=continuous-delivery.enabled=true
# ran into issues where helm couldnt download the helm charts - so - moved to downloading the tgz first
wget https://storage.googleapis.com/keptn-installer/keptn-${KEPTN_VERSION}.tgz
helm upgrade keptn keptn-${KEPTN_VERSION}.tgz --install -n keptn --create-namespace --wait --set=continuous-delivery.enabled=true
rm keptn-${KEPTN_VERSION}.tgz

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

cat > ./gen/keptn-ingress.yaml <<- EOM
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: istio
  name: api-keptn-ingress
  namespace: keptn
spec:
  rules:
  - host: keptn.$K8S_DOMAIN
    http:
      paths:
      - backend:
          serviceName: api-gateway-nginx
          servicePort: 80
EOM
kubectl apply -f ./gen/keptn-ingress.yaml

cat > ./gen/gateway.yaml <<- EOM
---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: public-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      name: http
      number: 80
      protocol: HTTP
    hosts:
    - '*'
EOM
kubectl apply -f ./gen/gateway.yaml

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
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.10.2/deploy/service.yaml

echo "4. Install the Dynatrace SLI Service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/release-0.7.3/deploy/service.yaml

echo "5. Enable Label & Annotation monitoring of key namespaces"
kubectl -n keptn create rolebinding default-view --clusterrole=view --serviceaccount=keptn:default
kubectl -n istio-system create rolebinding default-view --clusterrole=view --serviceaccount=istio-system:default

echo "6. Install Dynatrace Monaco Keptn Service"
kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-sandbox/monaco-service/release-0.2.1/deploy/service.yaml

echo "7. Authenticate Keptn CLI"
keptn auth  --api-token "${KEPTN_API_TOKEN}" --endpoint "${KEPTN_ENDPOINT}/api"

echo "8. Create Default Dynatrace project"
keptn create project dynatrace --shipyard=./shipyard.yaml