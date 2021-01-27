## Instrument Kubernetes with Dynatrace - Part 2

This lab guide will deploy Dynatrace integration for Kubernetes.

### Update Kubernetes Integration Settings

1. In Dynatrace Tenant, Click Settings -> Cloud and Virtualization -> edit icon for configured K8s cluster

   ![K8SConfig](../assets/011_k8sUI.png)    

3. Toggle the following switches:
   - Toggle OFF "Require valid certificates for communication with API server" (this workshop cluster uses self-signed).

   - Toggle ON "Monitor Prometheus exports"
   
   ![K8SToggles](../assets/012_k8sSlider.png)

4. Click Add event field selector

   ![K8SEventSelector](../../assets/images/addevent.png)

5. Add a field selector name and expression

   ![K8SEventSelector](../../assets/images/nonnodeevent.png)

   - Click Save.

6.  Toggle on Monitor events

   ![K8SMonitorEvents](../../assets/images/monitorevents.png)

7. Click Save.   
