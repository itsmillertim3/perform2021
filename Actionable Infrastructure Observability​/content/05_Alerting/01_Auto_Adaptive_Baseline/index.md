## Auto-Adaptive Baselines
### Create an auto-adaptive baseline alert for shop response time
- Navigate to Settings > Anomaly Detection > Custom Events for Alerting
- Create an auto-adaptive baseline
  - Metric: retail.shop.responsetime
  - Aggregation: Average
  - City: NewYork
  - Entity: None
  - Alert of anomalies of 1 time the normal signal fluctuation.
  - Metric is above baseline for 1 minute during any 5 minute period
  - Name: New York Response Time
  - Severity: Slowdown

![autobaseline](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/autobaseline.png)
