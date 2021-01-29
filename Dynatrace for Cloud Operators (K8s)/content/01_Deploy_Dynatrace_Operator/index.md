## Instrument Kubernetes with Dynatrace - Part 1

This lab guide will deploy the Dynatrace Operator for Kubernetes.

### Deploy Dynatrace

1. Navigate to Dynatrace tenant and select "Deploy Dynatrace" from left-hand navigation bar

   ![Deploy](/Dynatrace%20for%20Cloud%20Operators%20(K8s)/assets/images/001_DeployDT.png)

2. Search for "kubernetes", then select the kubernetes tile and then "Monitor Kubernetes"

   ![SearchForK8S](../assets/002_Deployk8s.png)
  
3. In the Monitor Kubernetes Deployment screen -> Create a new PaaS Token

4. Click "Generate Token" -> give your token a name -> click "generate" BE SURE TO COPY YOUR PAAS TOKEN

   ![CreatePaasToken](../assets/003_PaaSToken.png)

5. In the left-hand setting menu, select "Dynatrace API"

   ![APIToken](../assets/005_APITokenNav.png)
   
6. Create an API Token with the below permissions

   ![CreateAPIToken](../assets/006_APITokenConf.png)
   
   - After creating the PaaS token follow the step 1-3 above to get back to the kubernest deployment screen.

6. Select the PaaS and API tokens you previously created

   ![SelectTokens](../assets/007_OperatorConf.png)

7. Click the Copy Button next to the auto-generated wget command

   ![CopyScript](../assets/008_OperatorCopy.png)

8. Run Script on Bastion host

   ![RunScript](../assets/009_OperatorDeploy1.png)
   ![RunScript](../assets/010_OperatorDeploy2.png)

9. Verify Dynatrace Deployment
   
   ```
   kubectl get pods -n dynatrace
   ```
   ![RunScript](../assets/010_OperatorDeploy3.png)
