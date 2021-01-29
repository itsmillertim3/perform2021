## Deploy version 3 with Keptn

Now we deploy version 3 which should have no issues making it into production.
Whats different to version 1 is that in this case version 3 will first be deployed as a *Canary* next to the old version that is currently in production.
Once that *Canary* gets validated by Keptn it will be switched to become the main version. 

### Step 1: Deploy version 3

Just as we did before we use the hot_deploy.sh to deploy a new version. Now we deploy version 3
```bash
 ./hot_deploy.sh $STUDENTID 3
```

You will be able to watch Keptn deploy version 3 into staging, then run tests and then hopefully pass the quality gate to make it into production!


### Step 2: Validate

Validate that Dynatrace also shows the correct version in your staging and production environment part of your application.