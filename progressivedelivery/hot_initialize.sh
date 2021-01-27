#!/bin/bash

KEPTN_INGRESS=$(kubectl get cm -n keptn ingress-config -ojsonpath={.data.ingress_hostname_suffix})

# The following section will only be executed once to replace some placeholders in our monaco files
# For the first run we need to make sure we set the owner into the dashboard template
DT_USERNAME=${DT_USERNAME:-none}
if [ ! -f simplenode/monaco/projects/simplenode/dashboard/qualitygatedb.yaml ]; then
  if [[ "$DT_USERNAME" == "none" ]]; then
    echo "Please export DT_USERNAME=dynatraceusername as its needed for dashboard owner"
    exit 1
  fi
  sed "s/REPLACE_DASHBOARD_OWNER/$DT_USERNAME/g;s/REPLACE_KEPTN_BRIDGE/$KEPTN_INGRESS/g" simplenode/monaco/projects/simplenode/dashboard/qualitygatedb.yaml.tmpl >> simplenode/monaco/projects/simplenode/dashboard/qualitygatedb.yaml
fi 
# If we havent yet prepared the synthetic.yaml we do it now by replacing REPLACE_KEPTN_INGRESS with the actual KEPTN_INGRESS.
if [ ! -f simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml ]; then
  sed "s/REPLACE_KEPTN_INGRESS/$KEPTN_INGRESS/g" simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml.tmpl >> simplenode/monaco/projects/simplenode/synthetic-monitor/synthetic.yaml
fi 

echo "Thanks - you are now all set to start with the hot day hands ons, e.g: ./hot_createkeptnproject.sh studentxxx"