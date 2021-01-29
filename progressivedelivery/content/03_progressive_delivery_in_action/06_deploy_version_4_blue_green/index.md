## Deploy version 4 with Keptn

Now we deploy version 4 which should have no issues making it into production.
However - version 4 will have issues once it is in production. Good news is that Keptn deploys version 4 as a blue / green deployment. Once it detects that the new version is not good it will automatically flip back to version 3 without having any downtime.

### Step 1: Deploy version 4

Just as we did before we use the hot_deploy.sh to deploy a new version. Now we deploy version 4
```bash
$ ./hot_deploy.sh $STUDENTID 4
```

You will be able to watch Keptn deploy version 4 into staging, then run tests and then hopefully pass the quality gate to make it into production!


### Step 2: Validate

Validate that Dynatrace also shows the correct version in your staging and production environment part of your application.