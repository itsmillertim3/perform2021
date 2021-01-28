## Load Test Analysis Performance Issue

Learn how to use Dynatrace features that support Performance testing for each phase: scripting, analysis, and reporting

<img src="../../assets/images/lab_1_overview.png" width="500"/>

Now that we have our KIAB installed. 

Let's start by viewing a dashboard.

Click **"Dashboards"** from the Main Navigation menu.

Then Select the **"Autonomous Cloud Concepts with Keptn"** Dashboard.

<img src="../../assets/images/lab_1-acck-dashboard.png" width="500"/>

Now you should see your Dashboard.

<img src="../../assets/images/lab_1-acck-details.png" width="500"/>

Next we will create a few configuration items and kick off a load test.

### Configuration

1.  Create a service tag
1.  Process Detection Naming rule
1.  Architecture Validation
1.  Run first Load Test
1.  Describe Dynatrace Load Test Request Attribute
1.  Describe Calculated Service Metrics for Load Test Steps
1.  Kick off Keptn Customer 2 Build
1.  Update Keptn: keptnorders staging Management Zone
1.  Run Load Test
1.  Examine Performance Test Dashboard with Transaction Steps
1.  Load Test Performance Analysis

### Create Service tag

To support tagging, Dynatrace provides both a manual approach (Settings > Tags > Manually applied tags) and an automated, rule-based approach (Settings > Tags > Automatically applied tags).

We are going to apply a manual tag for this exercise.

First we need to create a tag on the service.
Navigate to **Transactions and services>frontend** 

<img src="../../assets/images/lab1_frontend_service.png" width="500"/>

We are looking for **frontend** with **keptnorders.staging.frontend [direct]**

Now we can create the **"evalservice"** tag.

<img src="../../assets/images/lab1_service_tag.png" width="500"/>

### Create Process Group Naming Rule (if not created)

Hopefully the naming rule has been created by the API call.  We need to validate that this has occurred.

If the rule is present, then we can skip to **Architecture Validation - Service Flow**

If the Rule has not been created, then we will need to follow these steps.

Go to **"Settings>Processes and Containers>Process group naming"**

<img src="../../assets/images/lab_1_gettoprocessgroup.png" width="500"/>

Then select "add new rule"

Now we will create the rule with the following parameters.

<img src="../../assets/images/lab_1_process_group_name.png" width="500"/>

You can cut and paste these items.

* Rule name: **Keptn Processgroup Naming**
* Process group naming format: **{ProcessGroup:Environment:keptn_project}.{ProcessGroup:Environment:keptn_stage}.{ProcessGroup:Environment:keptn_service} [{ProcessGroup:Environment:keptn_deployment}]**
* Conditions: **keptn_deployment (Environment)**

Click **"Preview"** -> **"create rule"** -> **"save changes"**

### Architecture Validation - Service Flow

As testers, we typically only test against the service endpoint. 

As performance engineers we should however understand:

- What happens end-to-end with that request?
- Which other services does it call? 
- How many round trips to the database does it make? 
- Does service load balancing and failover work correctly? 
- Do the caching layers work well? 
- Do we have any bad architectural patterns such as a data-driven N+1 query problem?

In Dynatrace, we analyze the Service Flow which shows us the full end-to-end flow of every request executed against our service endpoint. You can also apply filters to only focus on a particular test transaction, a specific time frame or compare the flow of failing vs non- failing transactions.

Click **"Applications"** from the Main Navigation menu. Then click **My web application**.

<img src="../../assets/images/lab_1_application_service_flow_1.png" width="500"/>

This will bring up the **My web application** Performance analysis screen.  

In the Dynatrace infographic click on the **1 Service** box.   Then under the **Called services** section click on the aqua box called **View service flow**.

<img src="../../assets/images/lab_1_application_service_flow_2.png" width="500"/>

This will bring up the **Service flow** for the **My web application**.  View results.

<img src="../../assets/images/lab_1_application_service_flow_3.png" width="500"/>

### Kick off our first load test

Login to Jenkins

* username = keptn
* password = keptn

<img src="../../assets/images/Lab_1_Jenkins_Log_In.png" width="500"/>

We are going to run the **03-simpletest-qualitygate pipeline**.
Click **"build"** this initial build will fail.
Refresh the page, now we can do a **"Build with Parameters"**

We need to change the Deployment URL

<img src="../../assets/images/lab_1_simple_test.png" width="500"/>

Click **Build**

### Describe Dynatrace Load Test Request Attribute

Dynatrace by default captures and traces every single incoming request on our instrumented applications and services. This allows us to analyze metrics (SLIs) for each individual endpoint URL. While this is great, the URL is not necessarily meaningful when we want to analyze details for a step from your load testing script, e.g: Login, Add to Cart, Checkout.

While executing a load test from your load testing tool of choice (JMeter, Neotys, LoadRunner, etc.) each simulated HTTP request can be tagged with additional HTTP headers that contain test-transaction information (for example, script name, test step name, and virtual user ID).

<img src="../../assets/images/lab_1_request_attribute_1.png" width="500"/>

The header **x-dynatrace-test** is used one or more key/value pairs for the header. Here are some examples:

<img src="../../assets/images/lab_2_dynatrace_headers_table.png" width="800"/>

Dynatrace can analyze incoming HTTP headers and extract such contextual information from the header values and tag the captured requests with request attributes. Request attributes enable you to filter your monitoring data based on defined tags.

You can use any (or multiple) HTTP headers or HTTP parameters to pass context information. The extraction rules can be configured via **Settings --> Server-side service monitoring --> Request attributes**.

We have setup the Load Test **Request attributes** for you.   Below is an example setup but we will also show you in your environment where they are.

<img src="../../assets/images/lab_1_request_attribute_2.png" width="500"/>

[Tag tests with HTTP headers](https://www.dynatrace.com/support/help/shortlink/load-testing-process#tag-test-requests-and-push-custom-events/)
  
### Describe Calculated Service Metrics for Load Test Steps

Dynatrace automatically captures important metrics for services with no configuration required. Additionally you might need additional business or technical metrics that are specific to your application. These metrics can be calculated and derived based on a wide variety of available data within the captured PurePath. This allows you to further customize key performance metrics for which alerts should be generated and helps you keeping an eye on them by pinning them to your dashboards.

For Performance Testing you can use Calculated service metrics to track your Performance transaction steps as an example.  Once created, these metrics can be used in Dashboards and alerting during the Performance Test but also can be used in analysis after the Performance test is complete. 

<img src="../../assets/images/Lab_1_Transaction_Scorecard.png" width="500"/>

We have setup the Load Test **Calculated service metrics** for you.   Below is an example setup but we will also show you in your environment where they are.  The Calculated service metrics can be configured via **Settings --> Server-side service monitoring --> Calculated service metrics**.

<img src="../../assets/images/lab_1_calculated_service_metrics.png" width="500"/>

[Create Calculated Service Metrics (SLIs) - Step #8 of this Blog](https://www.dynatrace.com/news/blog/guide-to-automated-sre-driven-performance-engineering-analysis/)

### Kick off Keptn Customer 2 Build

Click on **01_deploy_order_application** pipeline

<img src="../../assets/images/Lab_1_deploy_order_application_1.png" width="500"/>

Now we are going to push the **customer** version **2**.

Select **"Build with parameters"**

- In the **customerimage** field we need to change the value at the end from 1 to **2**
- In the DEPLOY_TO field, change the dropdown box to **customer**

Next, click the **Build** button.

<img src="../../assets/images/lab_1_customer_build.png" width="500"/>

### Update Keptn: keptnorders staging Management Zone

Each customizable management zone comprises a set of monitored entities in your environment, be it hosts that share a common purpose, a specific application, a staging environment, or services of a certain technology. Management zones may overlap, just as team responsibilities often overlap. Users may be granted access to entire environments, a specific management zone, or a subset of related management zones.

This exercise shows how to update a management zone that will be used in dashboards to show process and host metrics for analysis.

In Dynatrace on the navigation menu, navigate to **Settings --> Preferences --> Management zones**

Click **Keptn: keptnorders staging** management zone.

Then click the **Add new rule** button with configuration as show below:

- In the **Rule applies section** pick this dropdown:  **Process groups**
- In the **Conditions** section pick this dropdown:  **Process group name** 
- Keep **begins with** in the dropdown 
- In the text box section use: **keptnorders.staging**
- Select **apply to underlying hosts of matching process groups** check box
    
<img src="../../assets/images/lab_1_management_zone.png" width="500"/>

Click the **preview** button to verify.

<img src="../../assets/images/lab_1_management_zone_2.png" width="500"/>

Click **Create rule** button. 

Then **Save changes** button which will be at the bottom of the page.

## Run Load Test

Login to Jenkins

* username = keptn
* password = keptn

<img src="../../assets/images/Lab_1_Jenkins_Log_In.png" width="500"/>

We are going to run the **03-simpletest-qualitygate pipeline**.

Click on **"Build with Parameters"**.

We need to change the Deployment URL

<img src="../../assets/images/lab_1_simple_test.png" width="500"/>

Click **Build**

### Examine Performance Test Dashboard with Transaction Steps

We have provided a **Performance Test Dashboard with Transaction Steps** in your environment.   This dashboard provides a complete overview for your Performance Test focusing on SLIs (Latency, Traffic, Errors & Saturation).  Included in this dashboard is the following: Health Status, Transaction Steps Scorecard, Services Overview,  Database Overview,  Process Overview and Hosts Overview.   This dashboard also provides quick analysis links.  

Click **"Dashboards"** from the Main Navigation menu.

Then click the **Performance Test Dashboard with Transaction Steps**.

<img src="../../assets/images/lab_1_performance_test_dashboard_with_transaction_steps.png" width="500"/>

### Load Test Performance Analysis

Dynatrace uses a sophisticated AI causation engine, called Davis®, to automatically detect performance anomalies in your applications, services, and infrastructure. Dynatrace-detected problems are used to report and alert on abnormal situations, such as performance degradations, improper functionality, or lack of availability (i.e., problems represent anomalies in baseline system performance).

The Dynatrace AI works extremely well in high load environments where, over time, the AI has the chance to learn how your system behaves, understands dependencies and builds up baselines. If you only run sporadic load tests for short periods, the AI might not detect as many problems for you as in a high load production environment due to lack of good baselines. In any case the AI will spot critical problems and immediately show you the root cause. You can setup custom alerts with static thresholds.

If a Dynatrace Problem has generated a Problem during your Performance Test that is always a best place to start.

You can also analyze the data using custom Dashboards as well as out of the box workflows. Your approach should be based on the type of performance analysis you want to do (for example, crashes, resource and performance hotspots, or scalability issues). 

From the **Performance Test Dashboard with Transaction Steps** dashboard click on the **Transactions** link under **Transaction** links section on the left side of the dashboard.

<img src="../../assets/images/lab_1_performance_test_dashboard_with_transaction_steps_1.png" width="500"/>

This will bring us to **Multidimensional analysis** that is showing response time split by the **TSN** request attribute.   Note,  you can also create your own **Multidimensional analysis** views and save them by going to the Diagnostic tools-->Top web requests configure desired settings.

For Developers to understand how to avoid future performance issues and proactively optimize performance, you must be able to analyze real-time data and understand code performance bottlenecks.

We are going to focus on the **customer** step name transaction.

<img src="../../assets/images/lab_1_peformance_analysis_1.png" width="500"/>

Click on the ... at the end of the table for **customer** step name transaction which will bring up the **Analyze** menu. 

Click  **Response time hotspots** from the Analyze menu.

<img src="../../assets/images/lab_1_response_time_hotspots_1.png" width="200" height="300"/>

On the Response time analysis page it will display the average response time observed during the analyzed timeframe. On the left side of the infographic, under Distribution, you can see how much time is contributed by calls to other services, calls to databases, and code-level execution. On the right side, under Top findings, we see the biggest hotspots identified by Dynatrace. You can click any of these entries to view further details.

Within the current screen click on **View method hotspots** button which will drill to the **Method hotspots**.

<img src="../../assets/images/lab_1_response_time_hotspots_2.png" width="500"/>

In the **Method hotspots** screen click on **Hotspots** button.   This will change the view to the **Top hotspots**.  Click expand in the method call tree and you can see the method that is calling the top hotpot in the code. 

<img src="../../assets/images/lab_1_response_time_hotspots_3.png" width="500"/>

### Summary

-  We learned how the use the Dynatrace Service Flow for Architecture Validation
-  We learned what a x-dynatrace-test request header is, how to use it with a Performance testing tool and the importance for improving Performance Test results in Dynatrace
-  We learned what a Dynatrace Load Test Request Attribute is,  how to use it and the importance for improving Performance Test results in Dynatrace
-  We learned what a Dynatrace Calculated Service Metric is,  how to use it and the benefits for improving Performance Test results in Dynatrace
-  We covered the Performance Test Dashboard with Transaction Steps and how you can use it to assist in Performance Test Analysis
-  We learned how to analyze a Performance Test where a Performance issue was introduced by a new application build and how get to root cause in minutes using Dynatrace

### Questions and Answers? 


