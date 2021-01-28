## Synthetic SLO
### Create a synthetic availablity SLO
- Name: Homepage Availability SLO
  - Use existing percentage Toggle
  - Metric: builtin:synthetic.browser.availability.location.total
  - Evaluation Type: Aggregate
  - SLO Filter: type("SYNTHETIC_TEST"),entityName("Easytravel Home")
  - Target Percentage: 98%
  - Warning Percent: 99%
  - Timeframe: -1d
- Where do I get Metric Name from?
- Where do I get SLO Filter from?
- Add to Dashboard via SLO page pin icon
![syntheticslo](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/syntheticslo.png)
