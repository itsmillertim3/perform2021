## Check Lab Environment

Whether you use the lab environment as part of the Perform 2021 Hands on Training Day or whether you run it yourself lets make sure you have access to all environments.
For the Hands on Training Day you will see your environment details through Dynatrace University like shown here:

![](../../../assets/images/laboverview.png)

### 1. Access to your Dynatrace Environment

To access Dynatrace open the Dynatrace Environment URL and make sure you can login with the credentials provided!

### 2. Access to your Bastion Host

To access the Bastion Host you can either click on the **Open Terminal** link which will open a terminal window in the same browser window.
The other option is that you use any SSH client, e.g: PUTTY on Windows to connect to the provided IP with the provided username & password!

Once connected and logged in validate that in the home directory you find the `perform-2021-hotday` directory. Thats the git clone of our workshop!
Go ahead and change into the following directory:
```console
$ cd perform-2021-hotday/progressive delivery
```

In that directory you will find several bash scripts (*.sh) that we will need later:
```console
$ ls *.sh
hot_createkeptnproject.sh  hot_deletekeptnproject.sh  hot_deploy.sh  hot_getinfo.sh  hot_initialize.sh
```

### 3. Export your STUDENTID

Every student gets assigned a student id. that will help us separate our work as we work on a shared k8s cluster and shared Dynatrace Environment.
Once you have your student ID, e.g. student003 export it into the following environment variable:

```console
export STUDENTID=studentxxx
```

### 4. Access to all required links & tokens

One of the bash scripts gives us information about all necessary systems that are part of our lab. Its the `hot_getinfo.sh`. Lets execute it:
```console
$ ./hot_getinfo.sh
===============================================================================
Here are all the useful URLs and tokens you will need for the HOTDAY
===============================================================================
Your Student ID: studentxxx
Keptn Bridge URL: http://keptn.keptndomain/bridge
Keptn Bridge Username / Password: keptn / ABCDEFGHIJKLMNOPQRSTUVWXYZ
Deployed services will be available under 
  - Staging:    http://simplenode.-staging.keptn.keptndomain
  - Production: http://simplenode.-prod.keptn.keptndomain

===============================================================================
Dynatrace Tenant Url: https://abc12345.xxx.dynatracelabs.com
Dynatrace Username / Password: see it in Dynatrace University
===============================================================================

===============================================================================
Gitea user credentials: keptn / keptn#R0cks
===============================================================================

===============================================================================
For some of the excercises you need the Dynatrace API token in the DT_API_TOKEN Env Variable
To get this - simply run the following command:
export DT_TENANT=abc12345.xxx.dynatracelabs.com
export DT_API_TOKEN=ABCDEFGHKIJKLMNOP
```

Lets make sure we can access the Keptns Bridge and the Dynatrace Environment.
Open those links in your browser and login!
