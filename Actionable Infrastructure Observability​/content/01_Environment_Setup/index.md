## Environment Setup
Here are a few quick steps to get your environment ready for today's exercises.

### Step 1. Turn on Metric Ingest in the Dynatrace UI
- Navigate to Settings > Monitoring > Monitored Technologies
  - Scroll down to the bottom of the list
- Turn on Dynatrace OneAgent StatsD, Pipe, HTTP Metric API

### Step 2. Restart Telegraf
- Navigate to the terminal in DTU
```bash
(ubuntuvm)$ sudo systemctl restart telegraf
```

### Step 3. Clone Git Hub Repo
- In the DTU terminal
```bash
(ubuntuvm)$ git clone https://github.com/JasonOstroski/Perform2021-ActionableInfraScripts.git
```

### Step 4. Set up a browser monitor in the Dynatrace UI
- Navigate to Synthetics > Create a Synthetic Monitor
- Create a browser monitor
- URL is the Public IP address on port 8080
  - Ex: http://12.345.67.89:8080
  - Find the Public IP in the Environments tab in DTU 
  - Monitor Name: EasyTravel Home
- Leave all other defaults and select 3 locations
