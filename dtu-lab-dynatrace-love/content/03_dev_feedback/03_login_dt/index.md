## REST Login requests in Dynatrace


### Service-flow Login
- Now show the flow of a Login.
- Notice again the intertier-calls how they add up, the contribution of each service and the infrastructure where it’s running.

![Login Flow](../../../assets/images/flow_login.png)

### ResponseTime Hotspots Login
Open the ResponseTime Hotspots from the ReverseProxy. Notice the contribution from Tomcat the Calls to AuthenticationService (4x) and VerificationService (1x)

Notice the contribution by Method within the AuthenticationService and how it can tell us which method is taking the most time within a single transaction (even though we are moving in 2 digit ms time)