## Host Resource Utilization

In this lab you'll learn how to utilize the `metrics v2 API` to fetch resource utilization information for hosts in your environment. We'll build a sample script that pulls CPU, Memory and Disk utilization and flags any hosts that are over or under utilized.

### Step 1: Setup

1. Create a new file called `check_host_utilization.py`

2. Import the `requests` and `json` packages by adding the following lines to the top of the file, so we can fetch data from the API

   ```python
   import requests,json
   ```

3. Set up variables for your `tenant` and `key` replacing `<INSERT YOUR TENANT>` with the full URL of your tenant without the trailing slash and replacing `<INSERT YOUR KEY>` with your actual API key

   ```python
   tenant = "https://<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   ```

### Step 2. Configure API query details

1. We'll be using the `query` endpoint of the `metrics v2 API` to fetch our data. Add a variable to store the API endpoint

   ```python
   url = "/api/v2/metrics/query"
   ```

2. Create a list to store the metric selectors that we'll need for this example. We'll loop through these metric selectors and format them before sending the request. Storing them in a list makes things a little easier to manage

   ```python
   metrics = [
       "builtin:host.cpu.usage",
       "builtin:host.disk.usedPct",
       "builtin:host.mem.usage"
       ]
   ```

3. Add a list to store the metric transformations we'll use to get the exact data we need from our query. We'll use `names` to get the `names` of the hosts instead of just the Dynatrace IDs and `fold` to distill the data down to a single datapoint for each metric for each host 

   ```python
   transformations = [
       "names",
       "fold"
       ]
   ```

### Step 3. Set up and test the API call 

1. Concatenate all of the parts of the request URL and log the result to the console, so we can test it. We'll wrap the code in a function, so we can loop through our metric selectors and execute the same code for each

   ```python
   def fetch_metrics (metric):
       req_url = f'{tenant}{url}?api-token={key}&metricSelector={metric}:{":".join(transformations)}'
       print (req_url)
   ```

2. Add code to loop through the metric selectors and call our `fetch_metrics` function for each

   ```python
   for i in metrics:
       fetch_metrics(i)
   ```

3. Your code should look like this before proceeding

   ```python
   import requests,json

   tenant = "<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   url = "/api/v2/metrics/query"
   metrics = [
       "builtin:host.cpu.usage",
       "builtin:host.disk.usedPct",
       "builtin:host.mem.usage"
       ]
   transformations = [
       "names",
       "fold"
       ]

   def fetch_metrics (metric):
       req_url = f'{tenant}{url}?api-token={key}&metricSelector={metric}:{":".join(transformations)}'
       print (req_url)

   for i in metrics:
       fetch_metrics(i)
   ```

4. Run the code. You should see three URLs printed to the console. You can take these URLs and access them in a browser to make sure we get data displayed instead of an error

   ```bash
   $ python3 ./check_host_utilization.py
   ```
   
   Sample output:
   ```bash
   <INSERT YOUR TENANT URL>/api/v2/metrics/query?api-token=<INSERT YOUR KEY>&metricSelector=builtin:host.cpu.usage:names:fold
    <INSERT YOUR TENANT URL>/api/v2/metrics/query?api-token=<INSERT YOUR KEY>&metricSelector=builtin:host.disk.usedPct:names:fold
    <INSERT YOUR TENANT URL>/api/v2/metrics/query?api-token=<INSERT YOUR KEY>&metricSelector=builtin:host.mem.usage:names:fold
   ```

### Step 4. Add the actual API query

1. Add a message to output statuses as our code fetches metric data. Place the following code inside the `fetch_metrics` function. The first line just extracts the metric category from the metric selector (`cpu`, `disk`, `mem`) so we can use it in the message and elsewhere
   
   ```python
   m = metric.split('.')[1]
   print (f"Fetching {m} metric data...")
   ```

2. Perform the API request and print the result. Add the following to the `fetch_metrics` function to query the API using the URL we built in previous steps
   
   ```python
   response = requests.get(req_url)
   print(response)
   ```

3. If you run the code now, you won't see any of the returned data, only the response code from the request, which is hopefully `200`. If it isn't examine the code to make sure there aren't any issues before proceeding
   
4. Parse the json object returned from the API and print the result to inspect. Replace the existing `print(response)` line with the following lines that parse the json and log the result
   
   ```python
   jresponse = response.json()
   print (jresponse)
   ```

5. Now we'll add in the logic to look at each metric and determine if it is over or under utilized. We'll start by creating a list that we'll append entries to that will make up our output. Put the following line `ABOVE` the `fetch_metrics` function definition, so it maintains global scope. The list starts off with an entry for the header row of our csv output
   
   ```python
   issues = ["host,+/-,metric,value"]
   ```

6. Next we'll loop through our results and check the `value` to see if it's over 95% or under 5%. If it is, we add an entry to our `issues` list with the `hostname`, `over` or `under` depending on the value, the metric type that we created above (`cpu`, `disk`, `mem`), and the value of the metric. Add the following at the end of the `fetch_metrics` function
   
   ```python
   for i in jresponse["result"][0]["data"]:
      if i["values"][0] > 95:
         issues.append(f'{i["dimensions"][0]},over,{m},{i["values"][0]}')
      if i["values"][0] < 5:
         issues.append(f'{i["dimensions"][0]},under,{m},{i["values"][0]}')
   ```

7. Almost finished! Let's add a line to print out our issues list. Add the following line to the very end of our script
   
   ```python
   print ("\n".join(issues))
   ```

8. Time to check our work. Validate that your code looks like this
   
   ```python
   import requests,json

   tenant = "<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   url = "/api/v2/metrics/query"
   metrics = [
       "builtin:host.cpu.usage",
       "builtin:host.disk.usedPct",
       "builtin:host.mem.usage"
       ]
   transformations = [
       "names",
       "fold"
       ]
   issues = ["host,+/-,metric,value"]

   def fetch_metrics (metric):
       req_url = f'{tenant}{url}?api-token={key}&metricSelector={metric}:{":".join(transformations)}'
       m = metric.split('.')[1]
       print (f"Fetching {m} metric data...")
       response = requests.get(req_url)
       jresponse = response.json()
       for i in jresponse["result"][0]["data"]:
          if i["values"][0] > 95:
             issues.append(f'{i["dimensions"][0]},over,{m},{i["values"][0]}')
          if i["values"][0] < 5:
             issues.append(f'{i["dimensions"][0]},under,{m},{i["values"][0]}')

   for i in metrics:
       fetch_metrics(i)
   print ("\n","\n".join(issues))
   ```

9. Run the script and examine the output
   
   ```bash
   $ python3 ./check_host_utilization.py
   ```

   Sample output:
   ```bash
   Fetching cpu metric data...
   Fetching disk metric data...
   Fetching mem metric data...
   
   host,+/-,metric,value
   my_host,under,cpu,1.0
   other_host,over,disk,95.0
   ```
