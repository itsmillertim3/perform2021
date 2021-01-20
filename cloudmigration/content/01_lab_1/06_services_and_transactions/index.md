## Services

Web applications consist of web pages that are served by web servers and web application processses, for example Tomcat. Web and mobile applications are built upon services that process requests like web requests, web service calls, and messaging. 

Such "server-side services" can take the form of web services, web containers, database requests, custom services, and more. Services may in turn call other services such as web services, remote services, and databases services.

## 👍 How this helps

As you plan your migration, it is important to gain a complete picture of interdependency to the rest of the environment architecture at host, processes, services, application perspectives. Since time is always scarce, being able to do this in a single place can shorten assessment timelines.

## Review Service

Let’s now take a look at the transactions and Services by clicking on the `Transactions and services` left side Dynatrace menu.

💥 **TECHNICAL NOTE**: There a lot of services in this list. To help manage this list a [Dynatrace auto-tagging rule](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/) was added by the workshop scripts and we can now use a tag filter to make this list more manageable.

In the management zone drop down, choose `monolith`.

![image](../../../assets/images/lab1-pick-monolith-mz.png)

It should look like this:

![image](../../../assets/images/lab1-trans-services.png)

From the `Dynamic Web Requests` section on the right, click the `view Dynamic Requests` button to see what it calls. 

![image](../../../assets/images/lab1-dynamic-requests-arrow.png)

On this page you can view the transactions as time-series charts.

![image](../../../assets/images/lab1-dynamic-requests-chart.png)

On this page you can view the top 15 requests and their response time consumption. 

![image](../../../assets/images/lab1-dynamic-requests-list.png)

By clicking on one of the requests, the time-series charts are filtered to just that one request.

![image](../../../assets/images/lab1-request-filter.png)