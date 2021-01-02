#!/bin/bash

DT_TENANT=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.dt_tenant} | base64 --decode)
KEPTN_BRIDGE_URL=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn_bridge_url} | base64 --decode)
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