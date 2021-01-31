## Configure Keptn & Dynatrace integration
In order to use Keptn with Dynatrace for the QG we need to install the Dynatrace service and the Dynatrace SLI service.

### Step 1: Configure the Dynatrace Service for Keptn

The OneAgent Operator has already been deployed in earlier stages of the lab. However, we still need to install the Dynatrace Service for keptn which will allow keptn to communicate with Dynatrace for sending events and comments to Problems.

1. Execute the following command from your home directory to install the Dynatrace Service for Keptn

    ```bash
    (bastion)$ cd
    (bastion)$ ./bootstrap/box/scripts/installDynatraceServiceForKeptn.sh
    ```

1. This script will perform the following steps:
    - Create a secret called "dynatrace" which will hold the details of how to connect to the Dynatrace environment through the API
    - Deploy the [Dynatrace service](https://github.com/keptn-contrib/dynatrace-service) for Keptn from an [online resource](https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.10.0/deploy/service.yaml)
    - Set up the Dynatrace Service in keptn

    As part of setting up the Dynatrace Service for Keptn, the following are created:
    - Tagging rules for keptn_service, keptn_stage, keptn_project, and keptn_deployment
    - Problem notifications for sending events to the keptn API
    - Alerting profile for Problems

### Step 2: Install Dynatrace SLI service
In order to allow Keptn to use Dynatrace as an SLI provider we will need to install the [Dynatrace SLI Service](https://github.com/keptn-contrib/dynatrace-sli-service) for Keptn. This would allow us to write SLI definitions to obtain metrics from the Dynatrace API and use them as part of the evaluations.

    (bastion)$ kubectl apply -n keptn -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/0.7.0/deploy/service.yaml 

You should get as a response the following message

    serviceaccount/keptn-dynatrace-sli-service created
    role.rbac.authorization.k8s.io/keptn-dynatrace-sli-service-secrets created
    rolebinding.rbac.authorization.k8s.io/keptn-dynatrace-sli-service-secrets created
    deployment.apps/dynatrace-sli-service created
    service/dynatrace-sli-service created
