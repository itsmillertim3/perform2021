## Dynatrace Dashboards for K8s - Part 3

This lab guide will cover the standard dashboards that are part of K8s deployment.

### Navigating K8s Dashboards

1. In Dynatrace Tenant menu, Click Kubernetes, then click on Dashboards

   ![K8SConfig](../assets/lab3-k8s-selectDash.png)    

2. The Kuberbetes deployment created the following preset dashboards.
   - Click on the Kubernetes Cluster Overview dashboard.
   
   ![K8SToggles](../assets/lab3-k8s-step2-dashclusteroverview.png)

3. Explore the dashboard to see a performance overview of the cluster

   ![K8SEventSelector](../assets/lab3-k8s-step3-exploreclusteroverview.png)

5. Provide a field selector (other events) name and expression (involvedObject.kind!=Node)

   ![K8SEventSelector](../assets/014_k8sEventsS.png)

6. Toggle on Monitor events

   ![K8SMonitorEvents](../assets/015_k8sUISave.png)
   
   - Click Save. 

7. Verify Dynatrace Operator Deployment
   
   - Navigate to Kubernetes -> HoT 2021 
   - Scroll down to Name Spaces and select Dynatrace
   
   ![K8SVerifyDT](../assets/016_VerifyDT.png)

