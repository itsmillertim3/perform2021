#!/bin/bash

DT_TENANT=$(kubectl get secret dynatrace -n keptn -ojsonpath={.data.DT_TENANT} | base64 --decode)
KEPTN_BRIDGE_URL=$(kubectl get secret dynatrace -n keptn -ojsonpath={.data.KEPTN_BRIDGE_URL} | base64 --decode)
KEPTN_BRIDGE_USER=admin
KEPTN_BRIDGE_PASSWORD=$(keptn configure bridge --output | tail -1 | awk -F  ": " '/1/ {print $2}')
KEPTN_INGRESS=$(kubectl get cm -n keptn ingress-config -ojsonpath={.data.ingress_hostname_suffix})

echo "Here are all the useful URLs and tokens you will need for the HOTDAY"
echo "==============================================================================="
echo "Keptn Bridge URL: $KEPTN_BRIDGE_URL"
echo "Keptn Bridge Username / Password: $KEPTN_BRIDGE_USER / $KEPTN_BRIDGE_PASSWORD"
echo "Deployed services will be available under simplenode.staging.$KEPTN_INGRESS"
echo "==============================================================================="
echo "Dynatrace Tenant Url: $DT_TENANT"