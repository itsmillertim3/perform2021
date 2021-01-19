## Load Test Analysis Performance Issue

### Service tag

To support tagging, Dynatrace provides both a manual approach (Settings > Tags > Manually applied tags) and an automated, rule-based approach (Settings > Tags > Automatically applied tags).

We are going to apply a manual tag for this exercise.

First we need to create a tag on the service.
Navigate to **Transactions and services>frontend** 

<img src="../../assets/images/lab1_frontend_service.png" width="500"/>

We are looking for **frontend** with **keptnorders.staging.frontend [direct]**

Now we can create the **evalservice** tag.

<img src="../../assets/images/lab1_service_tag.png" width="500"/>


In this lab you will:

1.  Kick off Keptn Orders 2 Build
2.  Create Dynatrace Load Test Request Attribute
3.  Create Calculated Service Metrics for Load Test Steps
4.  Update Keptn: keptnorders staging Manament Zone
5.  Create KeptnOdersDatabase Database Service Rule Name
6.  Create Keptn Process group naming rule
7.  Tag Eval Service
8.  Run Load Test
9.  Import Performance Test Dashboard with Transaction Steps
10. Load Test Performance Analysis

### Kick off Keptn Orders 2 Build

1. Login to Jenkins

	username = keptn
	password = keptn

<img src="../../assets/images/Lab_1_Jenkins_Log_In.png" width="500"/>

2. Click on 01_deploy_order_application

<img src="../../assets/images/Lab_1_deploy_order_application_1.png" width="500"/>

3. 


### Create Dynatrace Load Test Request Header

