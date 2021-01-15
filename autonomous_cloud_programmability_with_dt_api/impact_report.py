import requests
import json

tenant = "<full tenant url>"
url = "/api/v2/entities/"
key = "<api key>"
hosts = {0: ["<entity id>"]}

def fetch_upstream (entity_ID, level):
    print ("Fetching upstream entities for", entity_ID, "at level", level)
    flat_hosts = str(hosts)
    response = requests.get(tenant + url + entity_ID + "?api-token=" + key)
    if "isNetworkClientOfHost" in response.json()["toRelationships"]:
        for i in response.json()["toRelationships"]["isNetworkClientOfHost"]:
            if flat_hosts.find(i["id"]) < 0:
                if level in hosts:
                    hosts[level].append(i["id"])
                else:
                    hosts[level] = [i["id"]]
                fetch_upstream (i["id"], level + 1)

fetch_upstream(hosts[0][0], 1)
print (hosts)
