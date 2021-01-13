import requests
import json

tenant = "https://vvl663.managed-sprint.dynalabs.io/e/e6ac6c11-917a-46fa-9da3-55a7265f572f"
url = "/api/v2/entities/"
key = "vgnbsx3yS12HsAsVjy33B"
hosts = {0: ["HOST-0788564003D72AEF"]}

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
