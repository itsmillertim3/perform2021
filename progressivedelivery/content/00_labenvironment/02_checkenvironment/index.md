## Check Lab Environment

Whether you use the lab environment as part of the Perform 2021 Hands on Training Day or whether you run it yourself lets make sure you have access to all environments.
For the Hands on Training Day you will see your environment details through Dynatrace University like shown here:

![](../../../assets/images/laboverview.png)

### 1. Access to your Dynatrace Environment

To access Dynatrace open the Dynatrace Environment URL and make sure you can login with the credentials provided!

### 2. Access to your Bastion Host

To access the Bastion Host we recommend you use your local SSH client, e.g: PUTTY on Windows.
You can connect to it with the IP Address, username and password given.
For HOTDAY we also provide the **Open Terminal** option but prefer if everyone connects via SSH to get their own terminal session. This avoids potential conflicts when setting environment variables and running programs!

Once connected and logged in validate that in the home directory you find the `perform-2021-hotday` directory. Thats the git clone of our workshop!
Go ahead and change into the following directory:
```console
$ cd perform-2021-hotday/progressivedelivery
```

In that directory you will find several bash scripts (*.sh) that we will need later:
```console
$ ls *.sh
hot_createkeptnproject.sh  hot_deletekeptnproject.sh  hot_deploy.sh  hot_getinfo.sh  hot_initialize.sh
```

### 3. Export your STUDENTID

Every student gets student ID assigned by the instructor, e.g: student123. We use this ID to separate our activities.
Once you have your student ID, e.g. student123 export it into the following environment variable:

```console
export STUDENTID=student123
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
DT_TENANT: abc12345.xxx.dynatracelabs.com
DT_API_TOKEN: ABCDEFGHKIJKLMNOP
```

Lets do the following
1. Copy this output to a local text document so we always have it handy
2. Lets open these links and validate we can access Keptn Bridge and Dynatrace Environment
