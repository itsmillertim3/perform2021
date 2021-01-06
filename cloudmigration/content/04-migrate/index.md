summary: Cloud Migration
id: 04-migrate
categories: dynatrace
tags: migration
status: Submitted
authors: Rob Jahn
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Cloud Migration Best Practices / Bridging the gap between legacy & cloud

## Migrate


Re-hosting (also referred to as lift and shift) is a common migration use case. Re-architecture and Re-platform are steps that break the traditional monolithic architectures and replace individual components with cloud services, such as Amazon Relational Database Service (Amazon RDS), which replaces on-premises relational databases) and Amazon DynamoDB, which replaces NoSQL databases. These steps can also replace newly-developed microservices, including containerized or serverless.

We just learned how we can get great information on back-end services, front-end API services, or user-facing features using Dynatrace and OneAgent. This helps us now decide what individual features or complete applications based on business benefits we need to migrate and modernize. The idea here is to focus on feature-based business benefit with functional migration.

![image](../../assets/images/henrik.png)

Meet Henrik, from the development team who is leading the easyTravel modernization implementation. We will work together with him as he begins the journey to move from the current easyTravel monolith to microservices.

### Objectives of this section

* Validate and Optimize Cloud Architecture
* Validate Migration Progress
* Validate Performance and Scalability

## Identify

EasyTravel is a monolithic Java application that as we saw earlier provides several web services like Booking, Authentication, and Journey.

Our overall goal at easyTravel is to breakout each of these backend services into separate services. This will allow us to have separate Continuous Integration (CI) pipelines to build and test each service independantly. By putting these service into Docker images, we gain the ability to deploy the service into modern platforms like Kubernetes using AWS managed services. By adding Continuous Deployment (CD) to our process, we will vastly increase our ability to delivery features faster to our customers.

![image](../../assets/images/adapt-microservices.png)

### Identify checkDestination to become a microservices

For this review, we are going to focus on the `JourneyService`.

Referring to the picture above, notice how the INTERMEDIATE STEP show the `JourneyService` resulting in two services:

* JourneyService
* checkDestination

As the lead developer, Henrik knows that within the code the checkDestination is a separate Java method and he would like to understand how often it gets called and the typical response times. This will help establish the Services Levels that will be required for monitoring and sizing.

### The Setup

Dynatrace automatically detects and monitors most server-side services in your environment with no configuration required. If your application doesn’t rely on standard frameworks, you can set up custom services.

With a custom service you can instruct Dynatrace which method, class, or interface it should use to gain access to each of your application’s custom server-side services.

Henrik knows the Java class and method within the JourneyService` and configured this custom service.

![image](../../assets/images/java-custom-service.png)


During the workshop provisioning we used the [Dynatrace API](https://www.dynatrace.com/support/help/dynatrace-api/configuration-api/service-api/custom-services-api/) to add this configuration. Navigate to the (**Settings –> Server-side service monitoring –> custom service detection**) to check it out.


### Service Review

1 . In Dynatrace, open the `transactions and services` page from the left side menu.

2 . Use the Management Zones filter to pick the `ez-travel` option

![image](../../assets/images/mz-filter.png)


During the workshop provisioning we used the Dynatrace Management Zones API to add this configuration. Navigate to (**Settings –> Preferences –> Management Zones**) to check it out.


3 . Use the `Technology` filter choosing the `Apache Tomcat` option. From the list, pick the `JourneyService`

![image](../../assets/images/pick-journey.png)

4 . On the Journey service page, click the View service flow button. Go ahead and change the Throughput view and expand the CheckDestination service to see the Request and response time details.

![image](../../assets/images/check-destination.png)

### What did we learn?

The `CheckDestination` service is called nearly each invocation to the `JourneyService` and its not a high contributor to overall time. So Henrik now has the informaton he needs to make smarter re-architecture and re-platforming decisions

## Scale

Due to the complexity and effort of refactoring a bunch of code, Henrik has decided to take a mixed cloud adoption strategy.

The intermediate step will be to support his developments efforts:

* **Refactor** the backend Java application to be packaged and served within a Docker image
* **Rebuild** relational in-memory Apache Derby database to Mongo

The final step be to put on AWS Kubernetes Service (EKS) and AWS DynamoDB once the Cloud operations team has completed their certification of AKS and DynamoDB.

![image](../../assets/images/adapt-docker.png)

### Let’s see what it looks like

In Dynatrace, go to the hosts page and open the host with **YOUR_LAST_NAME-workshop-ez-docker** as the prefix. This EC2 Instance was also provisioned earlier in this workshop. But this time, easyTravel was provisioned using Docker and Docker Compose. You can check out the docker-compose.yml file here

Now instead of a bunch of standalone Java processes, the host page shows the detected Docker containers. **And it did this with NO additional configuration changes or changes to the Docker image!!**

Go ahead and click on the `View container` button to see an overview of each container.

![image](../../assets/images/docker-host.png)

Also, go back and click the of the processes like **dynatrace/easytravel-frontend**.

### How Dynatrace monitors containers

Dynatrace hooks into containers and provides code for injecting OneAgent into containerized processes.

There’s no need to modify your Docker images, modify run commands, or create additional containers to enable Docker monitoring. Simply install OneAgent on your hosts that serve containerized applications and services. Dynatrace automatically detects the creation and termination of containers and monitors the applications and services contained within those containers.

![image](../../assets/images/docker-monitoring.png)


You can read more about Dynatrace Docker Monitoring [here](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/other-platforms/docker/basic-concepts/how-dynatrace-monitors-containers/) and technical details [here](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/other-platforms/docker/monitoring/monitor-docker-containers)


### Validate SLAs

During the workshop provisioning we used the [Dynatrace API](https://www.dynatrace.com/support/help/dynatrace-api/configuration-api/dashboards-api/) to add Dashboard that allows for a quick comparison of the non-Dockerized and Dockerized implementations of easyTravel.

Navigate the dashboards from the left side menu to analyze volumes, response times, and load.

![image](../../assets/images/dashboard.png)

### How this helps

Dynatrace monitors the progress of shifting workloads to the cloud. It helps us make better decisions on what to move when based on how tightly coupled services are and on the automatic baseline comparison between pre-migration and in-migration.

## Summary

While migrating to the cloud, you want to evaluate if your migration goes according to the plan, whether the services are still performing well or even better than before, and whether your new architecture is as efficient as the blueprint suggested. Dynatrace helps you validate all these steps automatically, which helps speed up the migration and validation process.

Having the ability to understand service flows enables us to make smarter re-architecture and re-platforming decisions.

As you have seen, Dynatrace has broad technology support and as things change, the views look the same to you without configuration changes or additional agents. **Simplicity in action!!**

## Checklist

In this section, you should have completed the following:

* Validate and Optimize Cloud Architecture
* Validate Migration Progress
* Validate Performance and Scalability