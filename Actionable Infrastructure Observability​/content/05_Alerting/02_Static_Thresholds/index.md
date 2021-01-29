## Static Thresholds
### Create a Static Threshold on CPU Temp
- Navigate to Settings > Anomaly Detection > Custom Events for Alerting
  - Metric: cpu.temperature
  - Aggregation: Average
  - Entity: Host
  - Static Threshold: 95
    - What’s the recommended threshold?
  - Raise if above threshold for 1 minute during 5 minute period
  - Review the Alert Preview
    - What happens if you change the threshold to 85?
    - Change back to 95 after review
- Title: CPU Temperature
- Severity: Resource

![static1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/static1.png)

![static2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/static2.png)

### Let's turn up the heat!
- Back in the DTU Terminal 
- Stop the retailresponsetime.py script if it’s still running (Ctrl + C)
- Start the retail script: 
  - HHMM is the time you’d like the CPU scenario to start
  - Start it a few minutes after the current time
  - You can run timedatectl to check current time
  - Ex: 1828 is 1:28 PM EST or 18:28 UTC
  - 10 is the number of minutes you’d like the scenario to run for
```bash
(ubuntuvm)$ python3 cputemp.py HHMM 10
```
- Wait a few minutes and let’s see the problem!


### Problem Evaluation
- Review the problem ticket
- Drill into the host and view the events
![problem](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/problem.png)
