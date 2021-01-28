## Shop Performance
### Create an area chart of average response time
- Metric: retail.shop.responsetime
- Aggregation: Average
- Pin to Infrastructure Overview dashboard

![shopresponsetime](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/shopresponsetime.png)

### Create a line chart, breaking down the response time by city
- Aggregation: Average
- Split by: city
- Pin to Infrastructure Overview dashboard

### Optional Exercise: Shop Performance Dashboard
- Create a 2nd Dashboard called Shop Performance to highlight East vs West Shop Performance
- Track East and West response times in different tiles of the dashboard
  - Metric: retail.shop.responsetime
  - Aggegration: Average
  - Split By: City
  - Filter by: Region useast or uswest
- Create a mark down link from the Infrastructure Overview dashboards
  - Create a mark down link from the Shop Performance Dashboard back to the Infrastructure Overview dashboard
  - Mark down example: ```[Region Breakdown](#dashboard;id=4e0089b5-8f38-4e8f-949f-1113acf79f5c)```
  - Mark down back button example: ```## [⇦](#dashboard;id=bbbbbbbb-0008-0000-0000-000000000000)```
- Where do I get the id values from?
![regionbreakdown](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/regionbreakdown.png)
