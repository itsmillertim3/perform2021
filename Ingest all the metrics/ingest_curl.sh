# CURL sample with Authentication / Public Rest-API
curl -H "Authorization: Api-Token <TOKEN>" -X POST -H "Content-Type: text/plain; charset=utf-8" --data-ascii "mymetric.rest 100" https://<env-URL>/api/v2/metrics/ingest

# CURL sample local OneAgent Ingest Channel
curl -X POST -H "Content-Type: text/plain; charset=utf-8" --data-ascii "mymetric.oa 200" http://localhost:14499/metrics/ingest
