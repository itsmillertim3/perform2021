## Thresholds

### Disk Used Threshold Chart
- Chart the Telegraf Disk Used Percent Metric in the Explorer
  - Aggregation: Average
- Thresholds
  - Green: Blank
  - Yellow: 40 
  - Red: 75
- Chart Mode: Column
- Pin to dashboard
  - Tile name: Disk Used %
![diskthreshold2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/diskthreshold2.png)
![diskthreshold1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/diskthreshold1.png)

### Top List with Thresholds: EC2 CPU
- Create a Top List with EC2 CPU Usage %
  - Aggregation: Average
  - Split by: de.entity.ec2_instance
  - Fold Transformation: Last
- Threshold: 
  - Green: 0
  - Yellow: 40 
  - Red: 60
- Pin to dashboard
![topthreshold1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/topthreshold1.png)
![topthreshold2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/topthreshold2.png)

### Optional: Top List with Threshold: Process CPU
- Create a Top List with Process CPU Usage
  - Aggregation: Average
  - Split by: Process
  - Fold Transformation: Last
- Threshold: 
  - Green: 0
  - Yellow: 5
  - Red: 20
- Pin to dashboard
![topthreshold1](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/topprocessthreshold1.png)
![topthreshold2](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/topprocessthreshold2.png)
