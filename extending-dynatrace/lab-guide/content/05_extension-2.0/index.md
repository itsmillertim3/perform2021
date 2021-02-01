## Extension 2.0, automate dashboard distribution

### Create a dashboard

Go to your tenant.

Go to dashboards.

Click create dashboard, enter a name for instance "extension 2.0".

Add one or more tiles to your dashboard and press done to save.

In the url bar of your browser grab the dashboard ID: https://xxxxxx.sprint.dynatracelabs.com/#dashboard;gtf=-2h;gf=all;id=b13472ec-6e7c-4e8d-baa3-df40a66c7ab9

For instance: b13472ec-6e7c-4e8d-baa3-df40a66c7ab9


## API Token
Create an API token if you don't already have one from Settings/integrations/dynatrace API/generate token.  

Ensure that you select read and write configuration, read write extensions and extension environment read and write.

Save the token in a text file as you won't be able to view it afterwards.


## Export the dashboard via our API

Go to the "little guy" (top right hand side), configuration api, press authorise, paste the token and authorise.

Go to the dashboards section, expand /dashboards/{id} (3rd link) and press "try it out".

Copy the dashboard Id in the box and press execute.

You should get a 200 ok response and see the dashboard data in the response field.

For instance:
```json
	{
	  "metadata": {
		"configurationVersions": [
		  3
		],
		"clusterVersion": "1.210.37.20210121-151318"
	  },
	  "id": "b13472ec-6e7c-4e8d-baa3-df40a66c7ab9",
	  "dashboardMetadata": {
		"name": "extension 2.0",
		"shared": false,
		"owner": "x.y@dynatrace.com",
		"sharingDetails": {
		  "linkShared": true,
		  "published": false
		},
		"dashboardFilter": null
	  },
	  "tiles": [
		{
		  "name": "Host health",
		  "tileType": "HOSTS",
		  "configured": true,
		  "bounds": {
			"top": 38,
			"left": 38,
			"width": 304,
			"height": 304
		  },
		  "tileFilter": {
			"timeframe": null,
			"managementZone": null
		  },
		  "filterConfig": null,
		  "chartVisible": true
		}
	  ]
	}
```
	
Save the output to a file called dashboard.json.

Modify the name of the dashboard to create a new version as we are using the same tenant so that when we re-import we will see a new dashboard. 

Remove the "id" : "xxxx" line.



## Create the extension

Inside a fresh folder or your choice, create a subfolder called dashboards, copy dashboard.json file in this folder.


Create a new file called extension.yaml at the root of your folder.
```yaml
name: com.dynatrace.demo.extension
version: 1.0.0
minDynatraceVersion: "1.209"
author: 
    name: demo
dashboards:
 - path: "dashboards/dashboard.json"
```
	


The structure should be as follow:

extension.yaml

dashboards/dashboard.json

Zip the files and call the file extension.zip


## Sign the extension
Create a key with openssl. 

Open a dos window (AKA cmd) and go to your project folder, type:

openssl genrsa -out customer_private.pem 4096

openssl dgst -sha256 -sign customer_private.pem -out extension.zip.sig extension.zip

zip extension.zip and extension.zip.sig under demoextension.zip



## Upload the extension to your tenant
Go back to swagger and switch to environment api V2.

Use the extension 2.0 section, POST extension (2nd link) and try it out. Don't forget to authorize yourself first.

Choose your demoextension.zip file, and press execute. 

Check that the extension has been uploaded successfully by checking the response.

To enable the extension, use the 8th link: POST extensions/extensionname/environmentConfiguration. Try it out.

Enter the name of the extension com.dynatrace.demo.extension and enter the correct version number (1.0.0).

Press execute. 

Check that the extension has been uploaded activated by checking the response.

Wait a few seconds and check that your dashboard has been imported on the Dynatrace UI under dashboards.
