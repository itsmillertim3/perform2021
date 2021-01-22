## Automated Performance Test

### Deployment automation 
Deployment automation is about the automated implementation of your application’s build, deploy, test 
and release process. In general, the automated deployment process is initiated whenever a developer 
commits code to a software repository inside the version control system (VCS) such as Subversion or Git. 
When the build automation server, which acts as the pipeline’s control center, such as Jenkins, 
observes a change in the repository, it triggers a sequence of stages which examine a build from 
different angles via automated tests, but terminates immediately in case of failure. Only when a build 
passes all stages it is regarded to be of sufficient quality to be released into production.


<img src="../../assets/images/keptn_logo.png"/>

- [keptn](https://keptn.sh/)

### What is keptn

**Keptn** is an event-based control plane for continuous delivery and automated operations for 
cloud-native applications.

#### Get full observability for your Keptn workflows
Keptn traces every event and all resulting actions and provides real-time tracing information 
and a powerful API enabling full visibility of every deployment and operations triggered via Keptn.

## keptn bridge

You can access the keptn bridge by opening the "Autonomous Cloud Concepts with Keptn" Dashboard in Dynatrace.
Then simply select the "Keptn Bridge" link.

<img src="../../assets/images/pre_keptn_bridge01.png" width="500"/>

You can also access the bridge from the KIAB page.

<img src="../../assets/images/pre_keptn_kiab.png" width="500"/>

Now let's take a quick tour of the keptn bridge. 

<img src="../../assets/images/lab_5_bridge.png" width="500"/>

### What do we see?

### Declarative Multi-Stage Delivery
Keptn allows to declaratively define multi-stage delivery workflows by defining what needs to be done. 
How to achieve this delivery workflow is then left to other components and also here Keptn provides 
deployment services, which allow you to setup a multi-stage delivery workflow without a single line of pipeline code.

<img src="../../assets/images/lab_5_pdw.png" width="500"/>

### Keptn Quality Gate Process
Keptn quality gates provide you a declarative way to define quality criteria of your service. 
Therefore, Keptn will collect, evaluate, and score those quality criteria to decide if a new 
version is allowed to be promoted to the next stage or if it has to be held back.

<img src="../../assets/images/lab_5_kqg.png" width="500"/>

### What is a Service-Level Indicator (SLI)?
A service-level indicator is a “carefully defined quantitative measure of some aspect of the level of 
service that is provided” (as defined in the Site-Reliability Engineering Book).

An example of an SLI is the response time (also named request latency), which is the indicator of how long
 it takes for a request to respond with an answer. Other prominent SLIs are error rate (or failure rate), 
 and throughput. Keptn defines all SLIs in a dedicated sli.yaml file to make SLIs reusable within several 
 quality gates. To learn more about the SLI configuration.

### What is a Service-Level Objective (SLO)?
A service-level objective is “a target value or range of values for a service level that is measured by an SLI.” 
(as defined in the Site-Reliability Engineering Book).

An example of an SLO can define that a specific request must return results within 100 milliseconds. 
Keptn quality gates can comprise several SLOs that are all evaluated and scored, based even on different 
weights for each SLO to consider different importance of each SLO. Keptn defines SLOs in a dedicated slo.yaml.


