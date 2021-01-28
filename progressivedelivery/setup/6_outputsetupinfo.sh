#!/bin/bash
# This script will list all important information about this installation

source keptn_helper.sh

echo "-----------------------------------------------------------------------"
echo "FINISHED SETUP!!"
echo "-----------------------------------------------------------------------"
echo "Keptn "

echo "API URL   :      ${KEPTN_ENDPOINT}/api"
echo "Bridge URL:      ${KEPTN_ENDPOINT}/bridge"
echo "Bridge Username: $BRIDGE_USERNAME"
echo "Bridge Password: $BRIDGE_PASSWORD"
echo "API Token :      $KEPTN_API_TOKEN"

echo "Git Server:      $GIT_SERVER"
echo "Git User:        $GIT_USER"
echo "Git Password:    $GIT_PASSWORD"
