## Exploring Dynatrace Release Inventory

There are 4 major sections on the release inventory screen:
1. Filter by application, environment, version, events, component
1. Real-time inventory overview based on filter
1. Issue tracking information based on filter
1. Release events based on filter

![](../../assets/images/01_release_inventory_sections.png)

**ATTENTION DEMO MODE**
In demo mode the filter only applies to the *Real-time inventory* section. The issue tracking and release events will always show the same demo data.
But don't worry: later on we will fill this with real data to see the true power of the filters in all sections of this view!

### Real-time inventory

This table lists so called components which basically represent Dynatrace Process Group Instances.
Additionally to the Process Group Name Dynatrace extracts meta data for
* Version: which software version, e.g: 1.42
* Environment: which environment, e.g: staging, prod, dev
* Application: which application it belongs to: easyTravel, Sock-Shop, hipster, ...

The table additionally shows important metrics such as
* Instances: number of running PGIs
* Requests: processed requests per min
* Problems: Number of open problems that have this PGI in the problem context

When clicking on the hour-glass you get a focused view of that component!

This table gives you answers such as
* Which versions of component X are deployed in which environment?
* Which components are part of application Y?
* How is load distribution between canary deployments?
* Is the latest version of component Y having any problems?

### Realtime release information

This area shows the result of queries against your issue tracking systems, e.g: Jira, GitHub Issues ...
We will see later that can you define different queries against your issue tracking system including filter criteria to match the filters that you select in this view, e.g: it will be possible to query "Number of Open Issues for the selected component".
The tiles will also be clickable opening up the actual list of issues in your external tracking system!

## Release events

This view shows all deployment, info, configuration or proces events that match the current filter. This allows you to answer questions such as
* When was the last deployments in a specific environment?
* When did we have process crashes on a particular service?
* Were there any configuration changes in a particular timeframe?