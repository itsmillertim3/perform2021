#!/bin/bash
# This script will apply Monitoring as Code configuration to the Dynatrace Tenant

source init.sh 

echo "-----------------------------------------------------------------------"
echo "Configure Dynatrace settings using Monaco - https://github.com/dynatrace-oss/dynatrace-monitoring-as-code"
echo "-----------------------------------------------------------------------"
echo "1. Download Monaco"
curl -L https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/v1.0.1/monaco-linux-amd64 --output monaco
chmod +x monaco

echo "2. Execute Monaco"
