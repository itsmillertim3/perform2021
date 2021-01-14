#!/bin/bash
# This script will apply Monitoring as Code configuration to the Dynatrace Tenant
# This includes some naming rules so that all deployed services and sample apps we use later on will be correctly identified

source init_helper.sh 

echo "-----------------------------------------------------------------------"
echo "Configure Dynatrace settings using Monaco - https://github.com/dynatrace-oss/dynatrace-monitoring-as-code"
echo "-----------------------------------------------------------------------"
echo "1. Download Monaco"
curl -L https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/v1.1.0/monaco-linux-amd64 --output monaco_cli
chmod +x monaco_cli

echo "2. Execute Monaco"
monaco_cli -e=monaco-environment.yaml -p=hotday monaco