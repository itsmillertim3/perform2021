## Load Test Analysis Performance Issue

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
5.  Update Keptn: keptnorders staging Management Zone
6.  Create KeptnOdersDatabase Database Service Rule Name
7.  Examine Performance Test Dashboard with Transaction Steps
8.  Kick off Keptn Orders 2 Build
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

### Kick off Keptn Customer 2 Build

Click on **01_deploy_order_application** pipeline

<img src="../../assets/images/Lab_1_deploy_order_application_1.png" width="500"/>

Now we are going to push the **customer** version 2.

Select **"Build with parameters"**

Then we need to change the build for customer to version 2 and select the build for **Customer**

<img src="../../assets/images/lab_1_customer_build.png" width="500"/>



### Create Dynatrace Load Test Request Header

