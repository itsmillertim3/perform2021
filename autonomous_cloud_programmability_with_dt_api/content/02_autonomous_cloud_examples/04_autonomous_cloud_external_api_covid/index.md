## External APIs - Positive COVID Cases (Metrics API v2)

In this lab you'll learn how to ingest data from external sources such as public APIs more specifically the COVID Tracking API via `Metrics API v2`. 

We're going to use the new endpoint `/api/v2/metrics/ingest​` to push externally retrieved metrics to Dynatrace over a secure and authenticated channel.

### Step 1: Find the metrics we want to feed into Dynatrace

1. Execute `curl -s --location --request GET 'http://covidtracking.com/api/us'` on your Linux host.

   ```bash
   (dtu.training@ip-10-0-0-X)$ curl -s --location --request GET 'http://covidtracking.com/api/us'
   ```

2. Use `jq` to parse the JSON in the command-line.

   ```bash
   (dtu.training@ip-10-0-0-X)$ curl -s --location --request GET 'http://covidtracking.com/api/us' | jq 
   ```

3. Change the output to show only positive COVID cases in the US.

   ```bash
   (dtu.training@ip-10-0-0-X)$ curl -s --location --request GET 'http://covidtracking.com/api/us' | jq -r '.[].positive' 
   ```

### Step 2. Feed custom metrics to Dynatrace via `Metrics API v2`

1. Provided data points must follow the metrics ingestion protocol. The general syntax of metric ingestion is the following:

   ```bash
   metric.key,dimensions payload
   ```

2. Change output to match format.

   ```bash
   (dtu.training@ip-10-0-0-X)$ curl -s --location --request GET 'http://covidtracking.com/api/us' | jq -r '.[].positive' | awk '{print "COVID.US.positive "$1}'
   ```

3. Create variable for data and curl `Metrics API v2`.
   - **NOTE:** Replace *TENANTID* with your tenant ID and *XXXXXXXXXXXXX* with your newly created API token from our last example.

   ```bash
   (dtu.training@ip-10-0-0-X)$ covid=$(curl -s --location --request GET 'http://covidtracking.com/api/us' | jq -r '.[].positive' | awk '{print "COVID.US.positive "$1}'); curl -X POST "https://TENANTID.live.dynatrace.com/api/v2/metrics/ingest" -H "accept: */*" -H "Authorization: Api-Token XXXXXXXXXXXXX" -H "Content-Type: text/plain; charset=utf-8" -d "$covid"
   ```

### Step 3. Automate the process! 

1. Run the following script with the edited command you made from our last step:

   ```bash
   while true; do covid=$(curl -s --location --request GET 'http://covidtracking.com/api/us' | jq -r '.[].positive' | awk '{print "COVID.US.positive "$1}'); curl -X POST "https://TENANTID.live.dynatrace.com/api/v2/metrics/ingest" -H "accept: */*" -H "Authorization: Api-Token XXXXXXXXXXXXX" -H "Content-Type: text/plain; charset=utf-8" -d "$covid"; sleep 60; done
   ```

### Step 4. Query Data in Data Explorer

1. Dynatrace UI -> Try it out -> COVID.US.positive
