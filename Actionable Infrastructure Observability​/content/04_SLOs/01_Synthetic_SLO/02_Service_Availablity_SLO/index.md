## Service Availablity SLO
### Create a Service Availablity SLO
- Name: Service Availability Authentication 
  - Count of success metric: builtin:service.errors.server.successCount
  - Total count metric: builtin:service.requestCount.server
  - Evaluation Type: Aggregate
  - SLO Filter: type("SERVICE"), entityId("SERVICE-12345XYZ")
    - Where do I get the entityId from?
  - Target percentage: 95%
  - Warning percentage: 97.5%
  - Timeframe: -1d
- Add it to the dashboard from the dashboard editor

![serviceslo](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/serviceslo.png)
