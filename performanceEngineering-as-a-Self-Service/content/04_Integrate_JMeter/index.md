### <img src="../../assets/images/jmeter.png" width="100"/> Jmeter Integration

Previously we discussed the Load Test Request Attributes.

To integrate Dynatrace with JMeter:

Within JMeter, use the HTTP Header Manager to add custom HTTP request headers. 
You can use any custom HTTP headers to pass context information. In this example, 
we use the header x-dynatrace-test and the set of key/value LSN=Scenario1;TSN=Put Item into Cart; for the header value. 
See Dynatrace and load testing tools integration for more details on the recommended key/value pairs. 

Good News, we have already added this into the jmeter scripts.

<img src="../../assets/images/lab_04_jmeter.png" width="500"/>

