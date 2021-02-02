## Upstream Impact Report

This example will utilize the `monitored entities v2 API` to crawl upstream dependencies starting at a single device. This technique could be used to build a system that reports potential upstream devices to keep an eye on when performing maintenance. We'll pull in details of our starting host, examining the immediate upstream dependencies and then recursively traverse upstream until we reach an entity with no upstream dependencies.

### Step 1: Setup

1. Create a new file called `potential_impact_report.py`

2. Import the `requests` and `json` packages by adding the following lines to the top of the file, so we can fetch data from the API

   ```python
   import requests,json
   ```

3. Set up variables for your `tenant` and `key` replacing `<INSERT YOUR TENANT>` with the full URL of your tenant without the trailing slash and replacing `<INSERT YOUR KEY>` with your actual API key

   ```python
   tenant = "<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   ```

### Step 2. Configure API query details

1. We'll be using the `query` endpoint of the `metrics v2 API` to fetch our data. Add a variable to store the API endpoint

   ```python
   url = "/api/v2/entities/"
   ```

2. Locate a host id as the starting host. In your tenant navigate to `Hosts` from the left hand menu. Select a host from the list. You'll find the host id in the URL after `id=` and before `;gtf=`

   Example URL:
   >[...].live.dynatrace.com/index.jsp?SHA=0#newhosts/hostdetails;id=`HOST-0A0A0A0A0A0A0A0A`;gtf=-2h;gf=all

3. Add a line to your script creating a dictionary that will store the level and host ids of the upstream devices. We start with our host id from above and a level of 0. Be sure to update `HOST-0A0A0A0A0A0A0A0A` to the actual host id from the previous step

   ```python
   hosts = {0: ["HOST-0A0A0A0A0A0A0A0A"]}
   ```

### Step 3. Set up and test the API call 

1. Concatenate all of the parts of the request URL and log the result to the console, so we can test it. We'll wrap the code in a function, so we can loop through our devices and execute the same code for each. We take two arguments (`entity_ID` for the host we're querying and `level` for the level we're at above the starting device)

   ```python
   def fetch_upstream (entity_ID, level):
       req_url = f'{tenant}{url}{entity_ID}?api-token={key}'
       print (req_url)
   ```

2. Add code to kick off the `fetch_upstream` function. Place the following at the end of the file outside of the function definition

   ```python
   fetch_upstream(hosts[0][0], 1)
   ```

3. Your code should look like this before proceeding

   ```python
   import requests,json

   tenant = "<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   url = "/api/v2/entities/"
   hosts = {0: ["HOST-0A0A0A0A0A0A0A0A"]}

   def fetch_upstream (entity_ID, level):
       req_url = f'{tenant}{url}{entity_ID}?api-token={key}'
       print (req_url)

   fetch_upstream(hosts[0][0], 1)
   ```

4. Run the code. You should see a URL printed to the console. You can take this URL and access it in a browser to make sure we get data displayed instead of an error

   ```bash
   $ python3 ./potential_impact_report.py
   ```
   
   Sample output:
   ```bash
   <INSERT YOUR TENANT URL>/api/v2/entities/HOST-0A0A0A0A0A0A0A0A?api-token=<INSERT YOUR KEY>
   ```

### Step 4. Add the actual API query

1. Add a message to output statuses as our code processes the dependencies. Place the following code inside the `fetch_upstream` function. This will just output the device ID and level that's being queried, so we can follow the flow
   
   ```python
   print(f"Fetching upstream entities for {entity_ID} at level {level}")
   ```

2. Create a variable called `flat_hosts` that contains a flattened copy of the `hosts` object, so we can hack together a check to make sure we're not looping endlessly when a host is a dependency of itself. In our logic we'll search this flattened dictionary to see if the ID we're about to query
   
   ```python
   flat_hosts = str(hosts)
   ```

3. Perform the API request and print the result. Add the following to the `fetch_upstream` function to query the API using the URL we built in previous steps
   
   ```python
   response = requests.get(req_url)
   print(response)
   ```

3. If you run the code now, you won't see any of the returned data, only the response code from the request, which is hopefully `200`. If it isn't examine the code to make sure there aren't any issues before proceeding
   
4. Parse the json object returned from the API and print the result to inspect. replace the existing `print(response)` line with the following lines that parse the json and log the result
   
   ```python
   jresponse = response.json()
   print (jresponse)
   ```

5. Now we'll add in the logic to examine the upstream dependencies. Let's start by finding and printing the list out. We start by making sure the entity has the `isNetworkClientOfHost` property which is located in the `toRelationships` property. Add the following to the end of the `fetch_upstream` function
   
   ```python
   if "isNetworkClientOfHost" in jresponse["toRelationships"]:
      print(jresponse["toRelationships"]["isNetworkClientOfHost"])
   ```

   Example output:
   ```bash
   [{'id': 'HOST-12345678910A', 'type': 'HOST'}]
   ```

6. Next we'll loop through the list, perform our check against the flattened dictionary and only fetch dependencies if the host isn't already in our dependency map. Add the following directly under our if statement created in the previous step. Be sure to indent, so this code is only executed if the condition is true
   
   ```python
   for i in jresponse["toRelationships"]["isNetworkClientOfHost"]:
      if flat_hosts.find(i["id"]) < 0:
   ```

7. We're getting close! We'll add some logic now to see if our `hosts` dictionary has an entry for the current level. If it does, we just append the current id to the list. If it doesn't, we create an entry for that level and add the device to it. Place the following code below our `flat_hosts` check above, so it runs if that condition is met
   
   ```python
   if level in hosts:
      hosts[level].append(i["id"])
   else:
      hosts[level] = [i["id"]]
   ```

8. One more thing to add to our function, and that's the line to recursively call `fetch_upstream` for each entity that's in our dependency list for this level. This will recursively fetch the next level up for each device until we get to the point where there's no more upstream dependencies. Add the following below our code from the previous step. It should not be a condition of that if statement, however, so be sure to indent accordingly
   
   ```python
   fetch_upstream (i["id"], level + 1)
   ```

9. Lastly, we need to print out the results. Add this print statement at the very end of our file
   
   ```python
   print (hosts)
   ```

10. Time to check our work. Validate that your code looks like this
   
   ```python
   import requests,json

   tenant = "<INSERT YOUR TENANT URL>"
   key = "<INSERT YOUR KEY>"
   url = "/api/v2/entities/"
   hosts = {0: ["HOST-0A789740F58755B4"]}

   def fetch_upstream (entity_ID, level):
      req_url = f'{tenant}{url}{entity_ID}?api-token={key}'
      flat_hosts = str(hosts)
      response = requests.get(req_url)
      jresponse = response.json()
      if "isNetworkClientOfHost" in jresponse["toRelationships"]:
         for i in jresponse["toRelationships"]["isNetworkClientOfHost"]:
            if flat_hosts.find(i["id"]) < 0:
               if level in hosts:
                  hosts[level].append(i["id"])
               else:
                  hosts[level] = [i["id"]]
               fetch_upstream(i["id"], level + 1)

   fetch_upstream(hosts[0][0], 1)
   print (hosts)
   ```

   9. Run the script and examine the output. The results are presented as a dictionary of lists with one entry for each level
   
   ```bash
   $ python3 ./potential_impact_report.py
   ```
