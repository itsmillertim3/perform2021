summary: Cloud Migration
id: 05-operate
categories: dynatrace
tags: migration
status: Submitted
authors: Rob Jahn
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Cloud Migration Best Practices / Bridging the gap between legacy & cloud

## Operate

Meet Emma from the Cloud Operations team who is already a bit stressed about supporting the current systems, now has some concerns about what is coming with the new changes. Here are a few:

* The current set of monitoring tools simply don’t work in the complex ecosystem of microservices and for technologies like Kubernetes
* Finding root cause of problems harder than ever before and the effort required goes beyond what is humanly possible when the application spans to the cloud providers and data centers and the explosion of interconnected services
* There are more possibilities for failures and more hiding spots for problems to sneak into the environment when software driving more than just the application
* Being woken up in the middle of the night and interfering with your weekends and vacations due to sev1 issues
Emma was very skeptical when she first heard about Davis, Dynatrace's deterministic AI engine that automatically detects problems for you and pinpoints the root cause and explains the business impact without needing any manual configurations.

But Emma knew a new way is required and it was time to rethink and transform how the team could leverage monitoring and observability, and after seeing Davis in action she is knows Davis will address her concerns and help the whole easyTravel team.

### Objectives of this section

* Review AWS Monitor
* Understand how DAVIS identifies problems - learn about smart baselines
* See a detailed example for problem and walk through what Davis found

## AWS Monitor

On the far left Dynatrace menu, navigate to the "AWS" menu.

![image](../../assets/images/dt-aws-dashboard-menu.png)

You may see “no data” initially as seen here. This is because Dynatrace makes Amazon API requests every 5 minutes, so it might take a few minutes for data to show untill we are done with application setup on AWS.

![image](../../assets/images/dt-aws-dashboard-blank.png)

Once data is coming in, the dashboard pages will look similar to what is shown below.

![image](../../assets/images/dt-aws-dashboard-overview.png)

![image](../../assets/images/dt-aws-dashboard.png)

### Review your metrics

Once data starts to be collected, click in the blue availability zone section located under the grey header labeled EC2 and you should see the list of availability zones below.  Click on **us-west-2c** and the EC2 instances will be listed. You should  find the Cloud9 instance which does NOT have a Dynatrace OneAgent running on it. Notice too how you automatically get regional and instance type data.

![image](../../assets/images/aws-monitor-list.png)

Click on the **Cloud9** instance, and you will see how this host still is represented in the same **Host** view that we saw earlier with the host running the OneAgent. The basic CPU and memory metrics from CloudWatch are graphed for you.  What is GREAT, is that this host is being monitored automatically by the Dynatrace AI engine and can raise a problem when there are anomalies.

![image](../../assets/images/aws-monitor-host.png)

### How this helps

The AWS monitor is a central way to get a picture and metrics for the AWS resources running against your accounts as you migrate. 

Read more about how to scale your enterprise cloud environment with enhanced AI-powered observability of all AWS services in [this blog](https://www.dynatrace.com/news/blog/monitor-any-aws-service/).

Also, be sure to check out [This github repository](https://github.com/Dynatrace/snippets/tree/master/product/dashboarding/aws-supporting-services) that contains custom dashboards for AWS Supporting Services.

## Simply Operations

Migrating to the cloud means there are more moving pieces to monitor and manage. As we have learned, Dynatrace fully automates monitoring through OneAgent and the native integration with AWS.

This is an example of Dynatrace in action where Davis detected a problem. It’s showing the business impact and root cause of the issue in a simple, straight-forward way that everybody understands.

![image](../../assets/images/dt-problem-view.png)

All the high-fidelity data collected by OneAgent is constantly ingested into the AI and through that deterministic AI capabilities Dynatrace identifies the actual root cause with unmatched precision. Davis also helps in providing you the business impact analysis in terms of applications, services, infrastructure components and the real users impacted by a certain anomaly.

![image](../../assets/images/dt-problem-view-evaluation.png)

## How this helps

Post-migration, Dynatrace’s deterministic AI engine, DAVIS, helps you run your applications smoothly, pinpointing production issues with root-cause information right at your fingertips. DAVIS leverages Smartscape dependency data, as well as the high-fidelity monitoring data from OneAgent. The AI can be fed with external events such as deployment or configuration change events from your CI/CD or deployment automation tools.

DAVIS’ unique capabilities for automated root cause detection can be integrated with ChatOps, VoiceOps, or auto-remediation actions. This brings your operation teams closer to what we call Autonomous Operations and enables business teams to make better decisions based on monitoring data by using voice or chat commands.

## How Davis Works

Davis is Dynatrace’s AI engine that is purpose-built for today’s web-scale enterprise clouds. Davis analyzes complex dependencies, creates application topology dynamically and helps you in anomaly detection.

### A Highlevel View of the Davis AI Engine

![image](../../assets/images/dt-davis-highlevel.png)

**1. Intelligent anomaly detection**

Problems in Dynatrace represent anomalies, i.e. deviations from a normal behavior or state. Such anomalies can be, for example, a slow service or a slow user login to an application. Whenever a problem is detected, Dynatrace raises a specific problem event indicating such an anomaly.

**2. Smart Baselines & Problems**

Context-rich data collection and baselining are the two fundamental pillars that anomaly detection is built on. A huge amount of high-quality and accurate data is necessary to determine baselines that can effectively be used to distinguish between normal and anomalous situations.

Dynatrace uses a sophisticated AI causation engine, called Davis, to automatically detect performance anomalies in your applications, services, and infrastructure. Dynatrace "problems" are used to report and alert on abnormal situations, such as performance degradations, improper functionality, or lack of availability (i.e., problems represent anomalies in baseline system performance).

**3. Causation versus correlation**

Davis uses deterministic AI which is a radically different approach to traditional machine learning. It performs an automatic fault-tree analysis, the same methodology NASA and the FAA are using. This is causation not correlation. The resulting root cause analysis is precise and reproducible step by step.

### How Dynatrace Davis analyzes a critical situation

Davis processes all data, whether it comes from a mainframe, the infrastructure, a cloud platform or the CI/CD pipeline. This enables Davis to provide the granularity and precision needed to automate the enterprise cloud, unlike traditional AI.

* **Automatic detection of topology and communications** - As Oneagent constantly discovers new resources in the environment and builds it into the topology maps. The direction of the communication is shown by the arrow with solid line between entities representing active communication.
* **Metric and event-based detection of abnormal component states** - The new AI engine automatically checks all component metrics for suspicious behavior. This involves the near real-time analysis of thousands of topologically related metrics per component and even your own custom metrics.

## Services Setup

Davis is designed to work with a baseline of behavior that usually takes several hours or days to establish.  Since we don't have time in this workshop to wait, we are going to use a feature of adjusting the anomoly detection rules for a couple of services so that Davis AI will detect a problem quickly.

Once we complete this seutp, we are going to trigger a problem that we will review together.

### Journey Service

1 . Navigate to the **Transactions and services** menu

![image](../../assets/images/dt-ai-pickservice.png)

2 . Use the filter to first find `JourneyService`.  Then type in **tag** and choose **workshop-group** and **ez-travel-monolith**.  From the remaining list pick the one highlighted here.

![image](../../assets/images/dt-ai-journey-filter.png)

3 . On the service page, pick the **Edit** menu item

![image](../../assets/images/dt-ai-journey-edit.png)

4 . Navigate to **Anomoly Detecection** menu

![image](../../assets/images/dt-ai-journey-enable.png)

5 . Turn off **Use global Anomaly detection settings**.  Adjust the settings for **Detect reponse time degrations**

![image](../../assets/images/dt-ai-journey-settings.png)

### Booking Service

1 . Navigate to the **Transactions and services** menu

![image](../../assets/images/dt-ai-pickservice.png)

2 . Use the filter to first find `BookingService`.  Then type in **tag** and choose **workshop-group** and **ez-travel-monolith**.  From the remaining list pick the one highlighted here.

![image](../../assets/images/dt-ai-booking-filter.png)

3 . On the service page, pick the **Edit** menu item

![image](../../assets/images/dt-ai-booking-edit.png)

4 . Navigate to **Anomoly Detecection** menu

![image](../../assets/images/dt-ai-booking-enable.png)

5 . Turn off **Use global Anomaly detection settings**.  Adjust the settings for **Detect increase in failture rate**

![image](../../assets/images/dt-ai-booking-settings.png)

## Enable a Problem

Various problem patterns that Dynatrace can detect are built into the easyTravel codebase so that we can easily simulate problems without redeploying the application.

### Turning on a problem pattern

The easyTravel has REST API that can be used to enable or disable a problem pattern.  To make this easier, scripts are provided that will find the IP address for your **YOUR_LAST_NAME-workshop-ez-monolith** instance and make the required HTTP REST call for the feature flag.

{{% notice info %}}
Best to run each problem pattern separately so that it is easier to analyze. It will take about 4-5 minutes for the problem pattern to completely be analyzed.
{{% /notice %}}

### Problem Pattern #1: CreditCardCheckError500

Causes Error in the Booking Service. Root cause is Communication plugin could not contact credit card verification application via named pipe in the Booking Service.

![image](../../assets/images/dt-ai-booking-problem.png)

1 . To enable this problem, run these commands.  The script output will just indicate the problem is now enabled.

```
cd ~/modernize-workshop-setup/aws
./setProblemPattern-CreditCardCheckError500.sh
```

2 . Navigate to the **Problems** page from the menu. In about a minute, the problem will appear.  Hit browswer refresh as required.   

![image](../../assets/images/dt-ai-problem.png)

Once the problem appears, checkout:

* Business impact analysis
* Impacted services
* Root cause
* Visual resolution path

![image](../../assets/images/CreditCardCheckError500.png)

3 . Disable the problem

The problem pattern will be turned on when the script is called. Turn off the problem pattern by just re-running the command and adding false as a parameter. For example: 

```
cd ~/modernize-workshop-setup/aws
./setProblemPattern-CreditCardCheckError500 false
```

### Problem Pattern #2: CPULoadJourneyService

Causes a response time issue impacting multiple services. Root cause is checkDesination Service in Journey Service from a high CPU function call.

![image](../../assets/images/dt-ai-journey-problem.png)

1 . To enable this problem, run these commands.  The script output will just indicate the problem is now enabled.

```
cd ~/modernize-workshop-setup/aws
./setProblemPattern-CPULoadJourneyService.sh
```

2 . Navigate to the **Problems** page from the menu. In about a minute, the problem will appear.  Hit browswer refresh as required.   

![image](../../assets/images/dt-ai-problem.png)

Once the problem appears, checkout:

* Business impact analysis
* Impacted services
* Root cause
* Visual resolution path

![image](../../assets/images/CPULoadJourneyService.png)


3 . Disable the problem

The problem pattern will be turned on when the script is called. Turn off the problem pattern by just re-running the command and adding false as a parameter. For example: 

```
cd ~/modernize-workshop-setup/aws
./setProblemPattern-CPULoadJourneyService false
```

### (Optional) Review what problems are enabled

This script will can also be used to review what problems are enabled.  Just run this to verify that the **CreditCardCheckError500** or **CPULoadJourneyService** is in the list. There will be other patterns in the list, but you can ignore them.

```
cd ~/modernize-workshop-setup/aws
./getProblemPatterns.sh
```

Sample output with **CreditCardCheckError500** enabled

```
--------------------------------------------------------------------------------------
Enabled Patterns on YOUR_LAST_NAME-dynatrace-modernize-workshop-ez-monolith (34.209.63.151)
--------------------------------------------------------------------------------------

CreditCardCheckError500
DatabaseCleanup
DummyNativeApplication.NET
DummyPaymentService
SocketNativeApplication
ThirdPartyAdvertisements
ThirdPartyContent
UseFinanceServiceWCF.NET
```

## Summary

What makes Dynatrace truly special and unique is Davis. Davis is the deterministic AI engine that automatically detects problems for you and pinpoints the root cause and explains the business impact without needing any manual configurations.

AI-supported baselining on the migrated services allows for validating the success of the migration project from a performance, resource and cost perspective. Live performance insights into the full stack allows us to:

* Dynamically scale and implement auto-mitigation strategies!
* Eliminate meaningless alerts and alert fatigue from disparate tools
* Validating Application & Reduce MTTR with Automated Root Cause Diagnostics

### Checklist

In this section, you should have completed the following:

* Understand how DAVIS identifies problems - learn about smart baselines
* See a detailed example for problem and walk through what Davis found