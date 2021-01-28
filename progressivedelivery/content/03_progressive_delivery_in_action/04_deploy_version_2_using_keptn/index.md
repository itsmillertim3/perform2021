## Deploy version 2 with Keptn

We all should have version 1 of our microservice deployed in staging and by now also in production.
Now - lets try to deploy more versions and explore whats happening

### Step 1: Deploy version 2

Just as we did before we use the hot_deploy.sh to deploy a new version. Now we deploy version 2
```bash
$ ./hot_deploy.sh $STUDENTID 2
```

You will be able to watch Keptn deploy version 2 into staging, then run tests and then most likely stop version 2 from entering production. 
Why? Because Version 2 has a built in high error rate which causes Keptn's SLO-based Quality Gate to stop it. 
For our purposes this is OK as we are just interested in deploying a new version into an environment and then validating whether Dynatrace also shows that same real time inventory view for us.

**Look at your SLO Quality Gate Dashboard**
In Dynatrace you will find your own Keptn Quality Gate dashboard. You can either open it in Dynatrace or get the link from the Keptn's Bridge as part of the Quality Gate Evaluation.


**Learn more about SLO-based Quality Gates**
SLO-based Quality Gates are however very powerful and important in Progressive Delivery. Thats why I encourage you to explore Keptn Quality Gates which is now also available as part of Dynatrace`s Cloud Automation Solution for Managed and soon for SaaS.
For more information also watch [Building an SLO-based Quality Gate in 5 Minutes with Dynatrace & Keptn](https://www.youtube.com/watch?v=650Gn--XEQE&list=PLqt2rd0eew1YFx9m8dBFSiGYSBcDuWG38&index=7&t=1s)


### Step 2: Validate

Validate that Dynatrace also shows the correct version in your staging environment part of your application.
