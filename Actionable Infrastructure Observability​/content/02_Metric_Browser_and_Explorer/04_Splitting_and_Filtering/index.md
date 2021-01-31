## Splitting and Filtering

### Splitting
- Create an area chart with Process Network Load
  - Metric: builtin:tech.generic.network.load
  - Aggregation: Average
  - Split by: Process 
  - Filter: Only show EasyTravel Processes and Nginx
- Pin to dashboard

![splitting1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/splitting1.png)

![splitting2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/splitting2.png)

### CPU Temp Split
- One of out servers is running high on CPU temp and we want to review the CPU temp vs usage 
- Create an area chart with CPU System Usage
  - Metric: builtin:host.cpu.system
  - Aggregation: Average
- Create a line chart with CPU Temp
  - This data comes from the script we started a few exercises back
  - Metric: cpu.temperature
  - Aggregation: Average
  - Split by: CPU
- Pin to dashboard

![cpusplitting1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/cpusplitting1.png)

![cpusplitting2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/cpusplitting2.png)
