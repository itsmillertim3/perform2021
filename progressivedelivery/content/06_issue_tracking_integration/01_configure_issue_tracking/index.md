## Configure Issue Tracking

In the Dynatrace Web UI you can access the **Release Issue Tracker Queries** UI via **Settings->Integration->Release Issue Tracker Queries**

The [Issue tracker integration](https://www.dynatrace.com/support/help/how-to-use-dynatrace/release-monitoring/issue-tracker-integration/) allows you to define a query to count the number of issues matching a specific query string. The flexibility of this comes in as you have placeholders in the query string that will later be replaced by the filters in the *Release Inventory* screen, e.g: if you filter on a specific `version` that version will be used in the query string if you use the placeholder `{VERSION}`

As of January 2020 Dynatrace supports queries against GitHub and Jira - more integrations might follow so please have a look at the support environments.

In the lab we will be setting up an integration together as we don't want to run into any API limits of these external Issue Tracking Services:

![](../../../assets/images/06_issuequeryconfig.png)

