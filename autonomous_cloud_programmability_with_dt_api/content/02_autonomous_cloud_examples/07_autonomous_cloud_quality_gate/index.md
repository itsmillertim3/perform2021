## Simple Quality Gate Validation

In this example we will code a Simple Quality Gate validation that performs a 'Before' and 'After' check of a given Code Deployment.  We will be using the service metric response time named `builtin:service.response.time`.  This example can later be extrapolated to conduct additional validations using other service metrics such as error rates, throughput, CPU, etc.

### Step 1: Startup our Sample Application and generate some load.

1. Login to your VM and execute:

   ```bash
   (dtu.training@ip-10-0-0-X)$ sudo nohup ./easytravel-2.0.0-x64/weblauncher/weblauncher.sh &
   ```

2. Using your web browser, navigate to the Weblauncher UI on the exteral IP of your VM, on port 8094 and kick off some load. On the EasyTravel Weblaunch page go to the `Production` tab, and click `Standard`.   

    ```bash
   http://{Your-VM-External-IP}:8094
    ```

3. In the Dynatrace UI navigate to `Transactions and Services`, and locate the service named `easyTravel Customer Frontend` and click on it. Now click on `Response Time` and confirm you're getting load.  

4. While on this page in the Dynatrace UI take note of the entity identifier of this service. The entity identifier can be found in the URL of the `Response Time` page, where you will see a string similar to the example URL shown below. Save the `SERVICE-#@##@##@###@` value, and put it aside in a text editor as we will need it later on. 

   *Example URL:*
   <https://{tenantid}.live.dynatrace.com/#newservices/serviceOverview;id=`SERVICE-#@##@##@###@`;gtf=-2h;gf=all>

### Step 2: Create our Code Deployment script

1. Export the following environment variables for your Dynatrace environment `DT_TENANT`, `DT_API_TOKEN`, `DT_ENTITY_ID`, and `DT_CHGEVENTDTTM`

    ```bash
    (dtu.training@ip-10-0-0-X)$ export DT_TENANT="{Tenant ID}.live.dynatrace.com"
    (dtu.training@ip-10-0-0-X)$ export DT_API_TOKEN="{API Token}"
    (dtu.training@ip-10-0-0-X)$ export DT_ENTITY_ID="{Service Entity ID from the prior step}"
    (dtu.training@ip-10-0-0-X)$ export DT_CHGEVENTDTTM=$(date +"%s")
    ```
2. Now that we have a "before" baseline load running, we will prepare our Code Deployment script. To do this we will create a shell script that will:

    - Post a `CUSTOM_DEPLOYMENT` event to our `'easyTravel Customer Frontend'` service.
    - Spike some load against our Web Application.  
    
    ```bash
    (dtu.training@ip-10-0-0-X)$ vi exec_code_deployment.sh
    ```
3. Copy the contents from below and `Insert` it into our exec_code_deployment.sh script. 

    ```bash
    #!/bin/bash

    if [[ -z "$DT_TENANT" || -z "$DT_API_TOKEN" || -z "$DT_ENTITY_ID" ]]; then
        echo "DT_TENANT, DT_API_TOKEN & DT_ENTITY_ID MUST BE SET!!"
        echo "DT_ENTITY_ID is the Dynatrace Monitored Entity ID, e.g: HOST-ABCD123213123 that this script sends an error event to"
        exit 1
    fi
    EVENT_TYPE=$1
    if [[ -z "$EVENT_TYPE" ]]; then
        EVENT_TYPE="CUSTOM_DEPLOYMENT"
    fi
    PROBLEM_TITLE=$2
    if [[ -z "$PROBLEM_TITLE" ]]; then
        PROBLEM_TITLE="Simulated Power outage"
    fi
    PAYLOAD='
    {
        "source" : "Quality Gate Sample Script",
        "deploymentName" : "Quality Gate Code Change",
        "deploymentVersion" : "v11.11.11",
        "eventType": "'$EVENT_TYPE'",
        "attachRules":{
            "entityIds" : ["'$DT_ENTITY_ID'"]
        },
        "customProperties":{
            "Triggered by": "Exec_Change.sh Script"
        }
    }
    '
    curl -X POST \
            "https://$DT_TENANT/api/v1/events" \
            -H 'accept: application/json; charset=utf-8' \
            -H "Authorization: Api-Token $DT_API_TOKEN" \
            -H 'Content-Type: application/json; charset=utf-8' \
            -d "$PAYLOAD" \
            -o curloutput.txt
    cat curloutput.txt
    numProcs=10
    duration=480
    if [ ! -z $3 ]; then
        duration=$3
    fi
    #setup bashtrap
    trap bashtrap INT
    #function to clean up
    function cleanup {
        echo "Cleaning up..."
        for i in $(ps -ef | grep curl | awk '{print $2}' >> /dev/null); do kill -9 $i; done
    }
    #cleanup if canceled early
    bashtrap(){
        echo "Load generation canceled."
    }
    site=site=http://localhost:8080
    for i in `seq 1 $numProcs`
    do
        echo "Spawning process ${i} against ${site}"
        curl -s -X POST "${site}?yay=[1-999999999]"  >> /dev/null &
    done
    echo "This deployment will run for $duration seconds.  Feel free to take a break!!!"
    sleep $duration
    cleanup
    echo "Done!"
    ```

4. Save the file. 

    ```bash
    <esc key> : wq
    ```

- Now back at the command line make sure the script is an executable file.

    **NOTE: We do NOT want to execute this file just yet!**

    ```bash
    (dtu.training@ip-10-0-0-X)$ chmod +x exec_code_deployment.sh
    ```

### Step 3. Using Python create our Quality Gate validation script 

1. We will now create a Python script that will run the Quality Gate validation. Create a file called `quality_gate_validation.py`

   ```bash
   (dtu.training@ip-10-0-0-X)$ vi quality_gate_validation.py
   ```

2. Import the following packages to the top of the file, so we can fetch data from the API.

   ```python
   import requests, os, time, json
   ```

3. Set the following variables `tenant`, `token`, `entity` and `change-event-time` by referencing our environment variables we previously created in our shell script, then add in our response time `metric`.

   ```python
    tenant = "https://" + str(os.getenv("DT_TENANT"))
    token = os.getenv("DT_API_TOKEN")
    change_event_time = int(os.getenv("DT_CHGEVENTDTTM")) * 1000
    entity = os.getenv("DT_ENTITY_ID")
    metric = 'builtin:service.response.time'
   ```
4. Now lets setup our API query URLs.  We will need a before and an after query that captures the time appropriate response data.

   ```python
    before_change_query = f'{tenant}/api/v2/metrics/query?metricSelector={metric}:percentile(50)' \
                        + f'&entitySelector=type("{entity.split("-")[0]}"),entityId("{entity}")'\
                        + f'&from={change_event_time-1800000}' \
                        + f'&to={change_event_time}' \
                        + f'&resolution=Inf'
    after_change_query = f'{tenant}/api/v2/metrics/query?metricSelector={metric}:percentile(50)' \
                    + f'&entitySelector=type("{entity.split("-")[0]}"),entityId("{entity}")' \
                    + f'&from={change_event_time}' \
                    + f'&to={change_event_time+1800000}' \
                    + f'&resolution=Inf'                     
   ```


5. Next, we setup the execution of our queries to include the necessary HTTP Headers, and we also want to load the JSON response data into their own variables.

   ```python
    before_change = requests.get(before_change_query, headers={"Content-Type": "application/json","Authorization": f"Api-Token {token}"})
    before_change_median_rt = json.loads(before_change.text)['result'][0]['data'][0]['values'][0]
    after_change = requests.get(after_change_query, headers={"Content-Type": "application/json","Authorization": f"Api-Token {token}"})
    after_change_median_rt = json.loads(after_change.text)['result'][0]['data'][0]['values'][0]
   ```
6. The only thing left to do is to setup the comparison of the before and after response data to validate that it does not exceed our Quality Gate performance objectives.  

   ```python
    if (before_change_median_rt-after_change_median_rt < -0.05*before_change_median_rt): 
        print(f"A difference larger than the 5% target was detected.  Consider investigation or change roll-back")
    else: 
        print(f"No Quality Gate impact detected after the change")
   ```

7. Your finished python script should now look like this:

    ```python
    import requests, os, time, json

    tenant = "https://" + str(os.getenv("DT_TENANT"))
    token = os.getenv("DT_API_TOKEN")
    change_event_time = int(os.getenv("DT_CHGEVENTDTTM")) * 1000
    entity = os.getenv("DT_ENTITY_ID")
    metric = 'builtin:service.response.time'

    before_change_query = f'{tenant}/api/v2/metrics/query?metricSelector={metric}:percentile(50)' \
                        + f'&entitySelector=type("{entity.split("-")[0]}"),entityId("{entity}")'\
                        + f'&from={change_event_time-1800000}' \
                        + f'&to={change_event_time}' \
                        + f'&resolution=Inf'
    after_change_query = f'{tenant}/api/v2/metrics/query?metricSelector={metric}:percentile(50)' \
                    + f'&entitySelector=type("{entity.split("-")[0]}"),entityId("{entity}")' \
                    + f'&from={change_event_time}' \
                    + f'&to={change_event_time+1800000}' \
                    + f'&resolution=Inf' 

    before_change = requests.get(before_change_query, headers={"Content-Type": "application/json","Authorization": f"Api-Token {token}"})
    before_change_median_rt = json.loads(before_change.text)['result'][0]['data'][0]['values'][0]
    after_change = requests.get(after_change_query, headers={"Content-Type": "application/json","Authorization": f"Api-Token {token}"})
    after_change_median_rt = json.loads(after_change.text)['result'][0]['data'][0]['values'][0]

    if (before_change_median_rt-after_change_median_rt < -0.05*before_change_median_rt): 
        print(f"A difference larger than the 5% target was detected.  Consider investigation or change roll-back")
    else: 
        print(f"No Quality Gate impact detected after the change")
    ```

### Step 4. Execute our Code Deployment and Quality Validation scripts and check the results

1. We will first kick off our Code Deployment. This will take approximately 10 minutes to run, so now might be a good time to take a break if you need one. 

   ```bash 
    (dtu.training@ip-10-0-0-X)$ bash exec_code_deployment.sh 
   ```

2. We will now run our Quality Gate validation script and check the results.

    ```bash
    (dtu.training@ip-10-0-0-X)$ python3 quality_gate_validation.py
   ```
