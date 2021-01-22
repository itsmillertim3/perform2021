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

## What do we see?

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

### Continuous Performance Verification

Keptn helps automating your tests by having Keptn triggering the test execution and evaluating the result of 
these performance tests. The result can then be automatically processed or presented in the Keptn Bridge to 
take further decisions. You can even expand this use case by letting Keptn deploying new versions of your 
applications to a test environment, succeeded by triggering and evaluating the tests.

<img src="../../assets/images/lab_5_ktap.png" width="500"/>


## Putting it all together.
```groovy
@Library('keptn-library')_
def keptn = new sh.keptn.Keptn()

node {
    properties([
        parameters([
         string(defaultValue: 'performance', description: 'Name of your Keptn Project for Performance as a Self-Service', name: 'Project', trim: false), 
         string(defaultValue: 'performancestage', description: 'Stage in your Keptn project used for Performance Feedback', name: 'Stage', trim: false), 
         string(defaultValue: 'evalservice', description: 'Servicename used to keep SLIs, SLOs, test files ...', name: 'Service', trim: false),
         choice(choices: ['dynatrace', 'prometheus',''], description: 'Select which monitoring tool should be configured as SLI provider', name: 'Monitoring', trim: false),
         choice(choices: ['performance', 'performance_10', 'performance_50', 'performance_100', 'performance_long'], description: 'Test Strategy aka Workload, e.g: performance, performance_10, performance_50, performance_100, performance_long', name: 'TestStrategy', trim: false),
         choice(choices: ['perftest','basic'], description: 'Decide which set of SLIs you want to evaluate. The sample comes with: basic and perftest', name: 'SLI'),
         string(defaultValue: 'http://frontend.keptnorders-staging.54.237.173.135.nip.io', description: 'URI of the application you want to run a test against', name: 'DeploymentURI', trim: false),
         string(defaultValue: '60', description: 'How many minutes to wait until Keptn is done? 0 to not wait', name: 'WaitForResult'),
        ])
    ])

    stage('Initialize Keptn') {
        // keptn.downloadFile('https://raw.githubusercontent.com/keptn-sandbox/performance-testing-as-selfservice-tutorial/release-0.7.3/shipyard.yaml', 'keptn/shipyard.yaml')
        keptn.downloadFile("https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/dynatrace/dynatrace.conf.yaml", 'dynatrace/dynatrace.conf.yaml')
        keptn.downloadFile("https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/slo_${params.SLI}.yaml", 'keptnorders/slo.yaml')
        keptn.downloadFile("https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/dynatrace/sli_${params.SLI}.yaml", 'keptnorders/sli.yaml')
        keptn.downloadFile('https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/jmeter/load.jmx', 'keptnorders/jmeter/load.jmx')
        keptn.downloadFile('https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/jmeter/basiccheck.jmx', 'keptnorders/jmeter/basiccheck.jmx')
        keptn.downloadFile('https://raw.githubusercontent.com/dthotday-performance/keptn-in-a-box/release-0.7.3.1/resources/jenkins/pipelines/keptnorders/jmeter/jmeter.conf.yaml', 'keptnorders/jmeter/jmeter.conf.yaml')
        archiveArtifacts artifacts:'keptnorders/**/*.*'

        // Initialize the Keptn Project
        keptn.keptnInit project:"${params.Project}", service:"${params.Service}", stage:"${params.Stage}", monitoring:"${monitoring}" // , shipyard:'shipyard.yaml'

        // Upload all the files
        keptn.keptnAddResources('dynatrace/dynatrace.conf.yaml','dynatrace/dynatrace.conf.yaml')
        keptn.keptnAddResources('keptnorders/sli.yaml','dynatrace/sli.yaml')
        keptn.keptnAddResources('keptnorders/slo.yaml','slo.yaml')
        keptn.keptnAddResources('keptnorders/jmeter/load.jmx','jmeter/load.jmx')
        keptn.keptnAddResources('keptnorders/jmeter/basiccheck.jmx','jmeter/basiccheck.jmx')
        keptn.keptnAddResources('keptnorders/jmeter/jmeter.conf.yaml','jmeter/jmeter.conf.yaml')
    }
    stage('Trigger Performance Test') {
        echo "Performance as a Self-Service: Triggering Keptn to execute Tests against ${params.DeploymentURI}"

        // send deployment finished to trigger tests
        def keptnContext = keptn.sendDeploymentFinishedEvent testStrategy:"${params.TestStrategy}", deploymentURI:"${params.DeploymentURI}"
        String keptn_bridge = env.KEPTN_BRIDGE
        echo "Open Keptns Bridge: ${keptn_bridge}/trace/${keptnContext}"
    }
    stage('Wait for Result') {
        waitTime = 0
        if(params.WaitForResult?.isInteger()) {
            waitTime = params.WaitForResult.toInteger()
        }

        if(waitTime > 0) {
            echo "Waiting until Keptn is done and returns the results"
            def result = keptn.waitForEvaluationDoneEvent setBuildResult:true, waitTime:waitTime
            echo "${result}"
        } else {
            echo "Not waiting for results. Please check the Keptns bridge for the details!"
        }

        // Generating the Report so you can access the results directly in Keptns Bridge
        publishHTML(
            target: [
                allowMissing         : false,
                alwaysLinkToLastBuild: false,
                keepAll              : true,
                reportDir            : ".",
                reportFiles          : 'keptn.html',
                reportName           : "Keptn Result in Bridge"
            ]
        )
    }
}
```
