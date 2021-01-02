#!/bin/bash
# This script will ensure that the k8s cluster is properly monitoring with Dynatrace
# It will install the OneAgent Operator and configure the k8s API Integration

source init.sh 

echo "-----------------------------------------------------------------------"
echo "Ensures k8s is properly monitored with Dynatrace"
echo "-----------------------------------------------------------------------"
