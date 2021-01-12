## Deploy Licensing ActiveGate Extension
In this activity, we’ll walk you through the deployment of the Licensing ActiveGate Extension. Your ActiveGate Extension will be executed on the ActiveGate and will enrich Dynatrace with additional license consumption metrics. 

> With ActiveGate extensions, you can extend Dynatrace monitoring to any remote technology that exposes an interface, where OneAgent installation isn't an option. For example, PaaS technologies, network devices, or cloud technologies. ActiveGate extensions (aka Remote Plugins) are executed on ActiveGate and can acquire metrics and topology from remote sources, fully integrating new-technology monitoring into Dynatrace Smartscape and problem detection. You need some Python expertise to develop ActiveGate extensions. For more information, see Introduction to ActiveGate extensions.

You can learn more at [Extensions](https://www.dynatrace.com/support/help/extend-dynatrace/extensions/) page.

### Prerequisites
- Installed Dynatrace Managed cluster
- Installed Environment ActiveGate
- Access to the cluster with admin rights
- Access to the _ActiveGate host_
- `Licensing` environment was created

In order to deploy Licensing ActiveGate Extension we will need to install Extensions SDK, upload the extension to Dynatrace and configure it. Following activity steps will guide you through that proccess.