## Instrumenting Kubernetes with Dynatrace

In this exercise we will install the Dynatrace Operator.


### 1. Deploy Dynatrace

1. Navigate to Dynatrace tenant and select "Deploy Dynatrace" from left-hand navigation bar

   ![Deploy](../assets/001_DeployDT.png)

2. Search for "kubernetes", then select the kubernetes tile and then "Monitor Kubernetes"
   ![SearchForK8S](../assets/002_Deployk8s.png)

3. In the Monitor Kubernetes Deployment screen -> Create a new PaaS Token

4. Click "Generate Token" -> give your token a name -> click "generate" BE SURE TO COPY YOUR PAAS TOKEN

   ![CreatePaasToken](../assets/003_PaaSToken.png)

5. Create API token

   ![CreateAPIToken](../../assets/images/createapitoken.png)

   - After creating the PaaS token follow the step 1-3 above to get back to this screen.

6. Select the PaaS and API tokens you created above

   ![SelectTokens](../../assets/images/selecttokens.png)

7. Click the Copy Button

   ![CopyScript](../../assets/images/copyscript.png)

8. Run Script on Bastion host

   ![RunScript](../../assets/images/runscript1.png)
   ![RunScript](../../assets/images/runscript2.png)


### 2. Update Kubernetes Integration Settings
1. In Dynatrace Tenant, Click Settings -> Cloud and Virtualization -> Kubernetes

   ![K8SConfig](../../assets/images/k8sconfig.png)


2. Click on the Edit icon for the configured K8S clustername

  ![ClusterEdit](../../assets/images/clusteredit.png)       


3. Set the toggle switches
   - Toggle off "Require valid certificates for communication with API server". This is because the workshop k8s cluster are using self signed certificates.

   - Toggle on "Monitor Prometheus exports"
   ![K8SToggles](../../assets/images/k8stoggles.png)

4. Click Add event field selector
   ![K8SEventSelector](../../assets/images/addevent.png)

5. Add a field selector name and expression

   ![K8SEventSelector](../../assets/images/nonnodeevent.png)

   - Click Save.

6.  Toggle on Monitor events

   ![K8SMonitorEvents](../../assets/images/monitorevents.png)

7. Click Save.   
