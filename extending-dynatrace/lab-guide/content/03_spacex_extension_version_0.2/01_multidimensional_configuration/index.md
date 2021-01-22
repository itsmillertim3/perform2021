## Multidimensional metrics and configuration

### Metric dimensions

A metric can have dimensions, in the SpaceX API the ships have multiple engines.  
Each engine has a name and its own thrust value.  
In Dynatrace, the metric is `thrust`, and it has a dimension called `Engine`

#### Define and send a dimension metric

Let's add the `thrust` metric to `plugin.json`:

```json
{"timeseries": { "key": "thrust", "unit": "Percent", "displayname": "Thrust", "dimensions": ["Engine"] }}
```

We can loop through the ship engines data, reporting the metrics for each engine:

```python
# Send a metric with dimensions
for engine in ship["thrust"]:
    device.absolute(key="thrust", value=engine["power"], dimensions={"Engine": engine["engine"]})

```

### Add configuration to the extension

The extension currently has a hardcoded URL in the python code.  
This is not a good practice, the extension should be customizable enough to accept different parameters.

Add a `SpaceX API URL` property to the `plugin.json` file.

```json
"properties": [
    {"key":  "url", "type": "String"}
  ],
  "configUI": {
    "displayName": "SpaceX",
    "properties": [
      {"key":  "url", "displayName":  "SpaceX API URL", "displayHint":  "http://54.158.160.249/v3/ships"}
    ]
  },
```

Remember to increase the version of the extension to `1.002` in the `plugin.json` file

The python code needs to be modified to use this property, instead of the hardcoded URL:

```python
def get_ships(self):
    return requests.get(self.config.get("url")).json()

```

### Testing and deployment

We now need to create a new file in the `src` directory, called `properties.json`.  
This file contains the properties the extension needs, it is only used during development by the `oneagent_sim` command, and is never deployed with the extension.

```json
{
  "url": "http://54.158.160.249/v3/ships"
}
```

Deploy the new version with `oneagent_build_plugin`

### Files for version 1.002

#### plugin.json

```json
{
  "name": "custom.remote.python.spacex",
  "version": "1.002",
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
  "properties": [
    {"key":  "url", "type": "String"}
  ],
  "configUI": {
    "displayName": "SpaceX",
    "properties": [
      {"key":  "url", "displayName":  "SpaceX API URL", "displayHint":  "http://54.158.160.249/v3/ships"}
    ]
  },
  "metrics": [
    {"timeseries":       { "key": "fuel", "unit": "Count", "displayname": "Fuel" }},
    {"timeseries":       { "key": "thrust", "unit": "Percent", "displayname": "Thrust", "dimensions": ["Engine"] }}
  ]
}

```

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

            # Send a metric with dimensions
            for engine in ship["thrust"]:
                device.absolute(key="thrust", value=engine["power"], dimensions={"Engine": engine["engine"]})

    def get_ships(self):
        return requests.get(self.config.get("url")).json()

```

#### properties.json

```json
{
  "url": "http://54.158.160.249/v3/ships"
}
```


