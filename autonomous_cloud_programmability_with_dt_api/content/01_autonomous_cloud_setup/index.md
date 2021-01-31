## Autonomous Cloud Programmability with Dynatrace APIv2

Welcome to the Autonomous Cloud Programability with Dynatrace v2 API Hands on Training class! In this class we will learn the Dynatrace v2 APIs by building out integrations to feed metric data into your tenant, fetch data from your tenant and build simple but effective automation.

### Goals

The goal of this class is to learn:

* How to integrate with the DT v2 APIs
* How metrics can easily be sent via different ingest channels
* Feed in data from external APIs
* How to query the data using Data Explorer
* Enrich Davis AI and Smartscape with your own business-critical metrics
* Grant Davis more visibility into your organizations KPIs​
* Use data in Dynatrace to enable automation in your organization
* Allow data to help you make informed decisions quickly


We will walk you through 3 main use case areas:

1. Get data into Dynatrace, enrich Dynatrace
2. Get knowledge out of Dynatrace
3. Integration and workflow automation

### Setup

1. Test login to your Dynatrace tenant
2. Ensure you have an API key (one should have been supplied)
3. Check terminal functionality to make sure you can log into your Linux vm from here
4. Get EasyTravel up and running

### Autonomous Cloud Examples

In this module, you will learn about metric ingestion which provides a simple way to push any custom metric to Dynatrace. There are a number of different ways we can go about this but in today's examples we will be focusing on the following channels:

- Scripting integration (dynatrace_ingest)
- Metrics API v2
- OneAgent REST API

Next we'll take a look at pulling data out of Dynatrace to answer questions or enable automation. The v2 APIs that we'll be covering include:

- Metrics v2
- Monitored Entities v2

#### Examples

- Logged in Users (dynatrace_ingest)
- Logged in Usernames, IP, Session (OneAgent REST API)
- Failed SSH Attempts (Metrics API v2)
- COVID Cases (External API via Metrics API v2)
- Host Resource Utilization
- Upstream Impact Report
- Quality Gate
