## Number of Logged in Users (Scripting Integration)

In this lab you'll learn how to ingest the number of users currently logged into your host via `dynatrace_ingest`.

### Step 1: Find the metric we want to feed into Dynatrace

1. Execute `who` on your Linux host.

   ```bash
   (dtu.training@ip-10-0-0-X)$ who
   ```

2. Change the output to show number of users only.

   ```bash
   (dtu.training@ip-10-0-0-X)$ who | wc -l
   ```

### Step 2. Feed custom metric to Dynatrace via `dynatrace_ingest`

1. Provided data points must follow the metrics ingestion protocol. The general syntax of metric ingestion is the following:

   ```bash
   metric.key,dimensions payload
   ```

2. Change output to match format

   ```bash
   (dtu.training@ip-10-0-0-X)$ echo host.users.active `who | wc -l` 

   ```

3. Pipe metric to `dynatrace_ingest` from the output.

   ```bash
   (dtu.training@ip-10-0-0-X)$ echo host.users.active `who | wc -l` | dynatrace_ingest -v
   ```

### Step 3. Automate the process! 

1. Run the following script:

   ```bash
   while true; do; echo host.users.active `who | wc -l` | dynatrace_ingest -v; sleep 10; done
   ```

### Step 4. Query Data in Data Explorer

1. Dynatrace UI -> Try it out -> host.users.active -> Max -> Split by host