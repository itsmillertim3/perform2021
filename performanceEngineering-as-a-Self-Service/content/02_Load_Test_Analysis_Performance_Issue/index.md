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

1.	Create a service tag
2.  Process Detection Naming rule
3.  Run first Load Test
4.  Describe Dynatrace Load Test Request Attribute
4.  Describe Calculated Service Metrics for Load Test Steps
5.  Kick off Keptn Customer 2 Build
6.  Describe Dynatrace Load Test Request Header
7.  Update Keptn: keptnorders staging Management Zone
8.  Examine Performance Test Dashboard with Transaction Steps
9.  Load Test Performance Analysis

### Create Service tag

To support tagging, Dynatrace provides both a manual approach (Settings > Tags > Manually applied tags) and an automated, rule-based approach (Settings > Tags > Automatically applied tags).

We are going to apply a manual tag for this exercise.

First we need to create a tag on the service.
Navigate to **Transactions and services>frontend** 

<img src="../../assets/images/lab1_frontend_service.png" width="500"/>

We are looking for **frontend** with **keptnorders.staging.frontend [direct]**

Now we can create the **"evalservice"** tag.

<img src="../../assets/images/lab1_service_tag.png" width="500"/>

### Create Process Group Naming Rule

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

While executing a load test from your load testing tool of choice (JMeter, Neotys, LoadRunner, etc.) each simulated HTTP request can be tagged with additional HTTP headers that contain test-transaction information (for example, script name, test step name, and virtual user ID).

Dynatrace can analyze incoming HTTP headers and extract such contextual information from the header values and tag the captured requests with request attributes. Request attributes enable you to filter your monitoring data based on defined tags.

You can use any (or multiple) HTTP headers or HTTP parameters to pass context information. The extraction rules can be configured via ```Settings --> Server-side service monitoring --> Request attributes```.

The header ```x-dynatrace-test``` is used one or more key/value pairs for the header. Here are some examples:

| **Key**   | **Description**   |
| --- | --- |
| VU  | Virtual User ID of the unique user who sent the request.  |
| SI  | Source ID identifies the product that triggered the request (JMeter, LoadRunner, Neotys, or other)  |
| TSN  | Test Step Name is a logical test step within your load testing script (for example, Login or Add to cart.  |
| LSN  | Load Script Name - name of the load testing script. This groups a set of test steps that make up a multi-step transaction (for example, an online purchase).  |
| LTN  | The Load Test Name uniquely identifies a test execution (for example, 6h Load Test – June 25)  |
| PC  | Page Context provides information about the document that is loaded in the currently processed page.  |

### Describe Calculated Service Metrics for Load Test Steps

Dynatrace automatically captures important metrics for services with no configuration required. Additionally you might need additional business or technical metrics that are specific to your application. These metrics can be calculated and derived based on a wide variety of available data within the captured PurePath. This allows you to further customize key performance metrics for which alerts should be generated and helps you keeping an eye on them by pinning them to your dashboards.

For Performance Testing you can use Calculated service metrics to track your Performance transaction steps.   These can be used in Dashboards and alerting during the Performance Test but also can be used in analysis after the Performance test is complete. 

<img src="../../assets/images/Lab_1_Transaction_Scorecard.png" width="500"/>

### Kick off Keptn Customer 2 Build

Click on **01_deploy_order_application** pipeline

<img src="../../assets/images/Lab_1_deploy_order_application_1.png" width="500"/>

Now we are going to push the **customer** version **2**.

Select **"Build with parameters"**

Then we need to change the build for customer to version 2 and select the build for **Customer**

<img src="../../assets/images/lab_1_customer_build.png" width="500"/>


### Update Keptn: keptnorders staging Management Zone

Each customizable management zone comprises a set of monitored entities in your environment, be it hosts that share a common purpose, a specific application, a staging environment, or services of a certain technology. Management zones may overlap, just as team responsibilities often overlap. Users may be granted access to entire environments, a specific management zone, or a subset of related management zones.

This exercise shows how to update a management zone that will be used in dashboards to show process and host metrics for analysis.

In Dynatrace on the navigation menu, navigate to ```settings --> preferences --> management zones```

Click ```Keptn: keptnorders staging``` management zone and add a new rule with configuration as show below.

    - Rule applies to Process groups
    - Process group name begins with = keptnorders.staging
    
<img src="../../assets/images/lab_1_management_zone.png" width="500"/>

Select ```apply to underlying hosts of matching process groups``` check box.

Click the ```preview``` button to verify.

Save the zone. Click ```create rule``` button. Then ```Save changes``` button.

### Examine Performance Test Dashboard with Transaction Steps


### Load Test Performance Analysis


