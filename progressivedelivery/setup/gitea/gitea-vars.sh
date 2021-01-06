#!/bin/bash
if [ $# -eq 1 ]; then
    # Read JSON and set it in the CREDS variable 
    K8S_DOMAIN=$1
    echo "Domain has been passed: $K8S_DOMAIN"
else
    echo "No Domain has been passed, getting it from the api-Ingress"
    K8S_DOMAIN=$(kubectl get ing -n keptn api-keptn-ingress -o=jsonpath='{.spec.rules[0].host}')
    echo "Domain: $K8S_DOMAIN"
fi

#Default values
GIT_USER="keptn"
GIT_PASSWORD="keptn#R0cks"
GIT_SERVER="http://git.$K8S_DOMAIN"

# static vars
GIT_TOKEN="keptn-token"
TOKEN_FILE=$GIT_TOKEN.json

echo "Username: $GIT_USER"
echo "Password: $GIT_PASSWORD"
echo "GIT-Server: $GIT_SERVER" 