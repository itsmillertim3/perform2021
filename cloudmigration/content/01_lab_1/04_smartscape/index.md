### Smartscape view

Let’s see how Dynatrace can visualize these processes using Smartscape.

1. Just click on the `...` box on the to the right of the host name
1. pick **Smartscape view** menu option
1. this will open Smartscape filtered to this EC2 Instance

![image](../../../assets/images/lab1-host-smartscape.png)

Feel free to explore the Smartscape.

### About Smartscape

Smartscape is Dynatrace's near real-time environment-topology visualization tool, is one of the most powerful features of Dynatrace. Smartscape auto-discovery delivers a quick and efficient visualization of all the topological dependencies in your infrastructure, processes, and services:

* On the horizontal axis, it visualizes all ingoing and outgoing call relationships within each tier
* On the vertical axis, it displays full-stack dependencies across all tiers
    * Datacenter
    * Hosts
    * Process
    * Service
    * Application

Enterprise have many hosts, services, and application that are ever changing. The ability to automatically discover and change as the environment changes is a key feature that Smartscape delivers.  Below is a picture taken from a more complex environment.

![image](../../../assets/images/lab1-smartscape.png)

## How this helps

Smartscape shows all the dependencies of a given service. Those include connections to queues, web servers, app servers, and a native process. The host view shows historical and live time-series data for usage as well as the consuming processes. This information allows us to better plan the migration, as all depending services must be considered during the migration.