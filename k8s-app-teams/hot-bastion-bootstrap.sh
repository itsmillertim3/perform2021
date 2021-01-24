#!/bin/bash

##############
## This script is specific to the Perform 2021 HOT class DT_ENVIRONMENT_ID
##############

YLW='\033[1;33m'
NC='\033[0m'

if [ -z "$DYNATRACE_ENVIRONMENT_ID" ]; then
    echo -e "${YLW}DYNATRACE_ENVIRONMENT_ID variable is not defined or accessible... exting${NC}"
    exit
else
    if [ -z "$DYNATRACE_TOKEN" ]; then
        echo -e "${YLW}DYNATRACE_TOKEN variable is not defined or accessible... exting${NC}"
    fi
fi

#install AG
wget -O /tmp/Dynatrace-ActiveGate-Linux.sh "https://$DYNATRACE_ENVIRONMENT_ID.sprint.dynatracelabs.com/api/v1/deployment/installer/gateway/unix/latest?arch=x86&flavor=default" --header="Authorization: Api-Token $DYNATRACE_TOKEN"
/bin/sh /tmp/Dynatrace-ActiveGate-Linux.sh

BASE_DIR=/home/dtu_training/dynatrace-k8s

git clone https://github.com/steve-caron-dynatrace/dynatrace-k8s.git $BASE_DIR

sed -i -r 's~DT_ENVIRONMENT_ID=(.*)~DT_ENVIRONMENT_ID\='"$DYNATRACE_ENVIRONMENT_ID"'~' $BASE_DIR/configuration.conf
sed -i -r 's~DT_API_TOKEN=(.*)~DT_API_TOKEN\='"$DYNATRACE_TOKEN"'~' $BASE_DIR/configuration.conf
sed -i -r 's~DT_PAAS_TOKEN=(.*)~DT_PAAS_TOKEN\='"$DYNATRACE_TOKEN"'~' $BASE_DIR/configuration.conf
sed -i -r 's~DT_CONFIG_TOKEN=(.*)~DT_CONFIG_TOKEN\='"$DYNATRACE_TOKEN"'~' $BASE_DIR/configuration.conf

chown -R dtu_training:dtu_training $BASE_DIR

## Execute the generic setup script
su dtu_training
cd $BASE_DIR && ./setup.sh

# Set persistent env variables
echo "export DYNATRACE_ENVIRONMENT_ID=$DYNATRACE_ENVIRONMENT_ID" >> /home/dtu_training/.profile
echo "export DYNATRACE_TOKEN=$DYNATRACE_TOKEN" >> /home/dtu_training/.profileecho "export DYNATRACE_TOKEN=$DYNATRACE_TOKEN" >> /home/dtu_training/.profile
