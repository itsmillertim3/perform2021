## Load Test Analysis Performance Issue

Now that we have our KIAB installed. 

Let's start by viewing a dashboard.

Click **"Dashboards"** from the Main Navigation menu.

Then Select the "Autonomous Cloud Concepts with Keptn" Dashboard.

<img src="../../assets/images/lab_1-acck-dashboard.png" width="500"/>

Now your Dashboard should load.

<img src="../../assets/images/lab_1-acck-details.png" width="500"/>




### Outline
In this lab you will:

1.	Create a service tag
2.  Kick off Keptn Orders 2 Build
3.  Create Dynatrace Load Test Request Attribute
4.  Create Calculated Service Metrics for Load Test Steps
5.  Update Keptn: keptnorders staging Manament Zone
6.  Create KeptnOdersDatabase Database Service Rule Name
7.  Create Keptn Process group naming rule
8.  Tag Eval Service
9.  Run Load Test
10.  Import Performance Test Dashboard with Transaction Steps
11. Load Test Performance Analysis


### Create Service tag

To support tagging, Dynatrace provides both a manual approach (Settings > Tags > Manually applied tags) and an automated, rule-based approach (Settings > Tags > Automatically applied tags).

We are going to apply a manual tag for this exercise.

First we need to create a tag on the service.
Navigate to **Transactions and services>frontend** 

<img src="../../assets/images/lab1_frontend_service.png" width="500"/>

We are looking for **frontend** with **keptnorders.staging.frontend [direct]**

Now we can create the **"evalservice"** tag.

<img src="../../assets/images/lab1_service_tag.png" width="500"/>

### Kick off Keptn Orders 2 Build

1. Login to Jenkins

	* username = keptn
	* password = keptn

<img src="../../assets/images/Lab_1_Jenkins_Log_In.png" width="500"/>

2. Click on 01_deploy_order_application

<img src="../../assets/images/Lab_1_deploy_order_application_1.png" width="500"/>

3. 


### Create Dynatrace Load Test Request Header

