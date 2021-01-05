## Send Custom Deployment Event

Dynatrace provides a rich [Events API](https://www.dynatrace.com/support/help/dynatrace-api/environment-api/events/post-event/) that allows you to send external events such as configuration changes, deployments, test start/stop, .. events to Dynatrace. These events will give the Davis AI more context when it detects the root cause of problems.
Besides enriching Davis AI these Events are also useful for other things such as feeding deployment version information to the Dynatrace Real time Inventory view.

You have already learned that Dynatrace automatically picks up version information from either k8s labels or from the DT_xx environment variables.
Now we are going to learn how to send a custom deployment event to send version information to an existing Process Group Instance.

For that we leverage the Dynatrace API Swagger UI - which makes it easy for us to execute API calls. We could also use other tools such as curl, Postman or any other tool that can send HTTP Requests. For our hands-on we will however use the Swagger UI as it is accessible through the Web Browser.

### Prerequisites

We will need the Dynatrace API Token to execute API calls. The easiest way to get the API token is to execute the hot_getinfo.sh in your bastion host.

