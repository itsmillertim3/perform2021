## Metric API
### Create an API Token
- Settings>Integration>Dynatrace API
- Generate Token, name it, and turn on:
  - API v1 - Access problem and event feed, metrics, and topology, Read Configuration, Write Configuration, User Sessions
  - API v2 - Read Metrics
  - Copy the value and store in a safe place
- Navigate to the API Explorer
  - Environment API v2
  - Authorize and paste in API Token
- GET /metrics/query 
  - Metric Selector: telegraf.cpu.usage_guest
  - View available options and output
![metricapi](/Actionable%20Infrastructure%20Observability%E2%80%8B/assets/images/metricapi.png)

### Postman Prep
Create a workspace: PerformHOT2021
- Import from RAW Text
- Open a new browser tab: https://github.com/JasonOstroski/Perform2021-ActionableInfraScripts/
- View Raw of metrics_api_postman_collection.json
- Copy the entire text and paste into Postman

### Postman
- Let’s get data from the Dynatrace Metric API!
- For the CPU and Disk GET Requests:
  - Replace {{URL}} in GET with your Dynatrace Environment
  - Be mindful that it’s easy to copy and paste https:// and it’s already in the GET
  - Replace {{API_TOKEN}} in the header with your API Token
- You can also do the replacements via Postman environments
