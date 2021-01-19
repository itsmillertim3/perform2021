# Log event ingest via HTTP interface (curl)
1. Plain text ingest
```Shell
curl -X POST --data "Log content" https://<env-URL>/api/v2/logs/ingest
     -H "Content-Type:text/plain; charset=utf-8" --header "Authorization:Api-Token ******"
```
2. JSON ingest
```Shell
curl -X POST "https://<env-URL>/api/v2/logs/ingest" -H "accept: */*" -H "Authorization: Api-Token ***"
     -H "Content-Type: application/json; charset=utf-8" --data "{\"content\":\"JSON log content\"}"
```
