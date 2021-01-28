## Active Usernames and IP (OneAgent REST API)

In this lab you'll learn how to ingest multiple metrics and dimensions more specifically the active username, IP address and session number via `OneAgent REST API`. 

We're going to use the local http://localhost:14499/metrics/ingest API endpoint to push locally retrieved metrics to Dynatrace over a secure and authenticated channel.

### Step 1: Find the metrics we want to feed into Dynatrace

1. Execute `who` on your Linux host.

   ```bash
   (dtu.training@ip-10-0-0-X)$ who
   ```

2. Change the output to show username, IP and session number only.

   ```bash
   (dtu.training@ip-10-0-0-X)$ who | awk '{print $1 " " $5" "NR}'
   ```

### Step 2. Feed custom metrics to Dynatrace via `OneAgent REST API`

1. Provided data points must follow the metrics ingestion protocol. The general syntax of metric ingestion is the following:

   ```bash
   metric.key,dimensions payload
   ```

2. Change output to match format.

   ```bash
   (dtu.training@ip-10-0-0-X)$ who | awk '{print "host.users.sessions,ip="$5",name="$1" "NR}'
   ```

3. Create variable for data and curl `OneAgent REST API`.

   ```bash
   (dtu.training@ip-10-0-0-X)$ data=$(who | awk '{print "host.users.sessions,ip="$5",name="$1" "NR}'); curl -d $data http://localhost:14499/metrics/ingest -H "Content-Type: text/plain; charset=utf-8"
   ```

4. (OPTIONAL) Open up another session on your host to see multiple logged in users.

### Step 3. Automate the process! 

1. Run the following script:

   ```bash
   while true; do; data=$(who | awk '{print "host.users.sessions,ip="$5",name="$1" "NR}'); curl -d $data http://localhost:14499/metrics/ingest -H "Content-Type: text/plain; charset=utf-8"; sleep 10; done
   ```

### Step 4. Query Data in Data Explorer

1. Dynatrace UI -> Try it out -> host.users.sessions -> Max -> Split by host, IP, name.