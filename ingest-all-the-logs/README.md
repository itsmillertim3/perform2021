# Log event ingest via HTTP interface (curl)
1. Plain text ingest
```Shell
curl -i -X POST --data "Log content" https://<env-URL>/api/v2/logs/ingest -H "Content-Type:text/plain; charset=utf-8" --header "Authorization:Api-Token ******"
```
2. JSON ingest
```Shell
curl -i -X POST https://ydm87138.sprint.dynatracelabs.com/api/v2/logs/ingest -H "Authorization: Api-Token h_ezSujRSN28aEJsUDqoo" -H "Content-Type: application/json; charset=utf-8" --data "{\"content\":\"JSON log content\",\"status\":\"error\"}"
```

# FluentD operations
1. Start fluentD and check status
```Shell
sudo systemctl start td-agent.service
sudo systemctl start td-agent.service
```
2. Check fluentD logs
```Shell
sudo tail -fn 100 /var/log/td-agent/td-agent.log
```
3. Review fluentD configuration file
```Shell
sudo vim /etc/td-agent/td-agent.conf
```
4. Push log events over HTTP input plugin (default configuration)
```Shell
curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test
```
5. Add user td-agent read/write access to specific folder
```Shell
setfacl -m 'u:td-agent:rwx' /home/ec2-user
```

# Active Gate operations
1. Start & stop Active Gate
```Shell
service dynatracegateway stop
service dynatracegateway start
```

2. Edit Active Gate custom.properties
```Shell
vi /var/lib/dynatrace/gateway/config/custom.properties​
```

