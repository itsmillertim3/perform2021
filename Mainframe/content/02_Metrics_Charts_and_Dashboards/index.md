## Metrics, Charts and Dashboards

In this module you will learn how to to define Custom metrics, Charts and Dashboards.

The goal is to create this sample Dashboard:

   ![Sample](../../assets/images/IBM_zSeries_Dashboard.png)

### Step 1: Create Dashboard
- Open the Dynatrace tenant provided to you
- Go to `Dashboards` and click on `Create Dashboard`
- Provide Dashboard name `IBM zSeries Performance` and type `Create
- This will bring you to an empty Dashboard

   ![Dashboard](../../assets/images/Dashboard.png)

### Step 2: Create "Host Health" Chart
- Drag & drop `Host health` tile into your Dashboard 
- Keep all defaults
- Click `Done`

### Step 3: Create "CICS Service" Chart
- Go to your CICS service (`Transactions and Services -> HVDACnnn`)
- Click on the three `...` right to the name of the CICS Service
- Select `Pin to Dashboard`, select the `IBM zSeries Performance` Dashboard and `Pin`

  ![Pin](../../assets/images/Pin.png)

- Keep the defaults and click `Done` for the Services Chart

### Step 4: Create "LPAR CPU Utilization" Chart
- Drag & Drop `Custom Chart` to your Dashboard 
- You might need to click `Edit` if you are not yet Edit mode
- Click `Configure Chart`
- Under `add Metric` select Category `Hosts`
- Under Metric select `z/OS General CPU Usage`
- Keep defaults and select `Pin as new tile`
- Select your Dashboard and `Pin`, then `Open Dashboard`



### Step 3: Create "Database" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 5: Create "CICS Transaction Most Frequent" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 6: Create "CICS Transaction High Overall CPU" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 7: Create "CICS Transaction Max Response Time" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 8: Create "CICS Transaction Failure Rate" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 9: Create "CICS Transaction  Average CPU Time" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### Step 10: Create "CICS Transaction Average Response Time" Chart
- Go to `Diagnostic tools` and and click on `Create analysis view`
- ...

### You've arrived
- You have successfully created a new Dashboard with your key Mainframe components! 





