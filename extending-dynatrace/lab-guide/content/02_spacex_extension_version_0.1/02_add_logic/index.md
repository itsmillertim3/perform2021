## Add extension logic

### Making external requests

We will consume data from the spacex API, specifically from the ships API.  
The URL for our spacex API instance is: `http://54.158.160.249/v3/ships`

Create a `get_ships` method to our `SpaceXExtension` class, it will look something like this:

```python
def get_ships(self):
    return requests.get("http://54.158.160.249/v3/ships").json()
```

We also need to import `requests` at the beginning of the file:
  
```python
import requests
```

  
`requests` is an *external dependency*. These should be declared in the `plugin.json` file, inside the `install_requires` array.

```json
"install_requires": ["requests"]
```


### Creating groups

The first thing we need to do in an Activegate extension, is to create at least one group.  
Here, we want to group ships by ship types, so we will have a group for each ship type.

Change the query method, so it:

1. Calls the `get_ships` method
2. Creates a group for every unique ship type

```python
def query(self, **kwargs):
    # Get a list of ships
    ships = self.get_ships()
   
    # Create groups
    # 1 - Get the unique names of the ship types
    ship_types = set([ship["ship_type"] for ship in ships])
    
    # 2 - Save groups in a dictionary for later use
    groups = {}
    for ship_type in ship_types:
       group_name = f"{ship_type} ships"
       groups[ship_type] = self.topology_builder.create_group(group_name, group_name)

```


### Adding metrics 

For every ship, we want to report the fuel usage.  
Declare a `fuel` metric in our `plugin.json` file:

```json
  "metrics": [
    {"timeseries": { "key": "fuel", "unit": "Count", "displayname": "Fuel" }}
  ]
```

We are now able to report this metric in our python code.  
First, we need to create a **Custom Device** for every ship.


```python
for ship in ships:
    self.logger.info(f"Processing ship {ship['ship_name']}")

    # Obtain the group from the dictionary we created earlier
    group = groups[ship["ship_type"]]

    # Create a custom device for each ship
    device = group.create_device(ship['ship_id'], ship['ship_name'])
```

The device has helper methods to add metrics. Add an absolute metric for fuel:

```python
# Send an absolute metric, a metric that is stored without any extra calculation
# device.absolute("fuel", ship["fuel"])
```

### Files for version 1.001

#### spacex_extension.py

```python
import requests
from ruxit.api.base_plugin import RemoteBasePlugin


class SpaceXExtension(RemoteBasePlugin):

    def query(self, **kwargs):
        # Get a list of ships
        ships = self.get_ships()

        # Create groups
        # 1 - Get the unique names of the ship types
        ship_types = set([ship["ship_type"] for ship in ships])

        # 2 - Save groups in a dictionary for later use
        groups = {}
        for ship_type in ship_types:
            group_name = f"{ship_type} ships"
            groups[ship_type] = self.topology_builder.create_group(group_name, group_name)

        for ship in ships:
            self.logger.info(f"Processing ship {ship['ship_name']}")

            # Obtain the group from the dictionary we created earlier
            group = groups[ship["ship_type"]]

            # Create a custom device for each ship
            device = group.create_device(ship['ship_id'], ship['ship_name'])

            # Send an absolute metric, a metric that is stored without any extra calculation
            device.absolute("fuel", ship["fuel"])

    def get_ships(self):
        return requests.get("http://54.158.160.249/v3/ships").json()

```

#### plugin.json

```json
{
  "name": "custom.remote.python.spacex",
  "version": "1.001",
  "metricGroup": "tech.SpaceX",
  "technologies": [
    "SpaceX"
  ],
  "favicon": "https://imgur.com/H0kgC2m.png",
  "type": "python",
  "entity": "CUSTOM_DEVICE",
  "source": {
    "package": "spacex_extension",
    "className": "SpaceXExtension",
    "install_requires": ["requests"]
  },
  "properties": [],
  "configUI": {
    "displayName": "SpaceX",
    "properties": []
  },
  "metrics": [
    {"timeseries": { "key": "fuel", "unit": "Count", "displayname": "Fuel" }}
  ]
}
```

### Testing and deployment


#### Testing

While inside the `src` folder, running the command: 

`oneagent_sim`

Will start your extension in development mode, where you can see the logs and metrics reported.  
To see the metrics, stop the process with a `Ctrl-Z`

#### Deployment

To deploy the extension to the Activegate and upload to Dynatrace, you can run

`oneagent_build_plugin`

To deploy the extension to the `built` folder, and not upload it to Dynatrace:

`oneagent_build_plugin -d ../built --no_upload`
