#!/bin/bash
# This script will ensure that the k8s cluster is properly monitoring with Dynatrace
# It will install the OneAgent Operator and configure the k8s API Integration

source init_helper.sh 
source keptn_helper.sh

echo "-----------------------------------------------------------------------"
echo "Ensures k8s is properly monitored with Dynatrace"
echo "-----------------------------------------------------------------------"
echo "1. Deploy OneAgent Operator"
helm repo add dynatrace https://raw.githubusercontent.com/Dynatrace/helm-charts/master/repos/stable
kubectl create namespace dynatrace

cat > ./gen/values.yaml <<- EOM
platform: "kubernetes"

oneagent:
  name: "oneagent"
  apiUrl: "https://$DT_TENANT/api"
  args:
    - --set-app-log-content-access=true
  skipCertCheck: false
  enableIstio: true

secret:
  apiToken: "$DT_API_TOKEN"
  paasToken: "$DT_PAAS_TOKEN"
EOM

helm install dynatrace-oneagent-operator dynatrace/dynatrace-oneagent-operator -n dynatrace --values ./gen/values.yaml
# remove file as it contains sensitive data!
rm ./gen/values.yaml


echo "2. Setup k8s API Integration"
# kubectl create namespace dynatrace
kubectl apply -f https://www.dynatrace.com/support/help/codefiles/kubernetes/kubernetes-monitoring-service-account.yaml
DT_K8S_CONFIG_NAME="Keptn k8s Cluster - $K8S_DOMAIN"
K8SAPI_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
K8SBEARER_TOKEN=$(kubectl get secret $(kubectl get sa dynatrace-monitoring -o jsonpath='{.secrets[0].name}' -n dynatrace) -o jsonpath='{.data.token}' -n dynatrace | base64 --decode)
curl -X POST "https://$DT_TENANT/api/config/v1/kubernetes/credentials" \
     -H "accept: application/json; charset=utf-8" \
    -H "Authorization: Api-Token $DT_API_TOKEN" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "{\"active\":true,\"label\":\"$DT_K8S_CONFIG_NAME\",\"endpointUrl\":\"$K8SAPI_URL\",\"authToken\":\"$K8SBEARER_TOKEN\",\"eventsIntegrationEnabled\":true,\"workloadIntegrationEnabled\":true,\"prometheusExportersIntegrationEnabled\":true,\"eventsFieldSelectors\":[{\"label\":\"Node events\",\"fieldSelector\":\"involvedObject.kind=Node\",\"active\":true},{\"label\":\"All non-node events\",\"fieldSelector\":\"involvedObject.kind!=Node\",\"active\":true}],\"certificateCheckEnabled\":false}"

echo "3. Deploy a HelloWorld Sample App to validate monitoring and initialize CUSTOM_PROPS needed later"
kubectl apply -n default -f ./helloworld_setup_deployment.yaml
kubectl wait --namespace=default --for=condition=Ready pods --timeout=300s --all

