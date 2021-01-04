#!/bin/bash

DT_TENANT=$(kubectl get secret dynatrace -n keptn -ojsonpath={.data.DT_TENANT} | base64 --decode)
DT_API_TOKEN=$(kubectl get secret dynatrace -n keptn -ojsonpath={.data.DT_API_TOKEN} | base64 --decode)
KEPTN_BRIDGE_URL=$(kubectl get secret dynatrace -n keptn -ojsonpath={.data.KEPTN_BRIDGE_URL} | base64 --decode)
KEPTN_BRIDGE_USER=admin
KEPTN_BRIDGE_PASSWORD=$(keptn configure bridge --output | tail -1 | awk -F  ": " '/1/ {print $2}')
KEPTN_INGRESS=$(kubectl get cm -n keptn ingress-config -ojsonpath={.data.ingress_hostname_suffix})

echo "==============================================================================="
echo "Here are all the useful URLs and tokens you will need for the HOTDAY"
echo "==============================================================================="
echo "Your Student ID: $STUDENTID"
echo "Keptn Bridge URL: $KEPTN_BRIDGE_URL"
echo "Keptn Bridge Username / Password: $KEPTN_BRIDGE_USER / $KEPTN_BRIDGE_PASSWORD"
echo "Deployed services will be available under "
echo "  - Staging:    http://simplenode.studentxxx-staging.$KEPTN_INGRESS"
echo "  - Production: http://simplenode.$STUDENTID-prod.$KEPTN_INGRESS"
echo ""
echo "==============================================================================="
echo "Dynatrace Tenant Url: https://$DT_TENANT"
echo "Dynatrace Username / Password: see it in Dynatrace University"
echo ""
echo "==============================================================================="
echo "For some of the excercises you need the Dynatrace API token in the DT_API_TOKEN Env Variable"
echo "To get this - simply run the following command:"
echo "export DT_API_TOKEN=$DT_API_TOKEN"