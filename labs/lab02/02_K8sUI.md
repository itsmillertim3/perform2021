## Instrument Kubernetes with Dynatrace - Part 2

This lab guide will deploy Dynatrace integration for Kubernetes.

### Update Kubernetes Integration Settings

1. In Dynatrace Tenant, Click Settings -> Cloud and Virtualization -> edit icon for configured K8s cluster

   ![K8SConfig](../assets/011_k8sUI.png)    

3. Toggle the following switches:
   - Change the connection name to "HoT 2021".

   - Toggle OFF "Require valid certificates for communication with API server" (this workshop cluster uses self-signed).

   - Toggle ON "Monitor Prometheus exports"
   
   ![K8SToggles](../assets/012_k8sSlider.png)

4. Click Add event field selector

   ![K8SEventSelector](../assets/013_k8sEvents.png)

5. Provide a field selector (other events) name and expression (involvedObject.kind!=Node)

   ![K8SEventSelector](../assets/014_k8sEventsS.png)

6. Toggle on Monitor events

   ![K8SMonitorEvents](../assets/015_k8sUISave.png)
   
   - Click Save. 

7. Verify Dynatrace Operator Deployment
   
   - Navigate to Kubernetes -> HoT 2021 
   - Scroll down to Name Spaces and select Dynatrace
   
   ![K8SVerifyDT](../assets/016_VerifyDT.png)
