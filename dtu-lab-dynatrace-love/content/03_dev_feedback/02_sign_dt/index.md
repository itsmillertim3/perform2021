## REST Sign-In requests in Dynatrace

### MDA FeedBack Developer
- Go to MDA and search the request by `{RequestAttribute:Developer}`
- Filter your requests and show the Service-Flow. 
 
 
### ServiceFlow of the Developer Requests
- Start the flow from the nginx reverse proxy.
- By not filtering the 3 requests (2x signin + 1x login) you’ll see the flow of the 3.


### Filter by the first correct sign-in

> Let’s analyze first the correct signin.
- Fiter by _HTTP Code 200_ + Request _“sign”_ notice that you don’t need to match the exact name of the request.
- Notice how Dynatrace shows detailed information from every service and inter-tiercalls as DB calls.


### Response Time Hotspots Sign-In
> Navigate with the Response Time Hotspots all the way to the Database. Follow the services. Notice the detailed information about the SQLs and even the Connection Acquisitions.


### Difference between the 2 Sign-In
Can you notice the difference from the two Sign-in why the second Sign-in failed? That it got an HTTP 403 is obvious. But if you look at the purepaths in detail you’ll notice that the select statement of the first Sign-In did not return any results from the database on the select statement hence it could create an account and subsequently an Insert was done. In the second attempt since there was a result (a row) returned, no Insert statement or new Account was created.