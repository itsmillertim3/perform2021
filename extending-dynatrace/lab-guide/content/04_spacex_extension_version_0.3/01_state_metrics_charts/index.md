## Properties, state metrics and charts

### Properties

A Custom Device can have properties and endpoints.  
Properties are key-value pairs, that can be used as metadata for the device, example: version, model, etc.  
Endpoints are IPs, DNS records and ports.

#### Reporting an endpoint

The most basic endpoint is an IP address:

```python
device.add_endpoint(ship["ship_ip"])
```

You can optionally add ports, port ranges and DNS entries as well.

#### Reporting properties

Properties are simple key-value pairs, **they need to be strings**

```python
device.report_property("Home port", ship.get("home_port", ""))
device.report_property("Roles", ",".join(ship.get("roles", [])))

```

### State metrics

State metrics are special metrics, they allow you to send string values instead of floats to Dynatrace.  
To use them, you must first declare what possible string values will be sent.  
  
Ships have a `weather` property that is a string, we can add the possible values to the `plugin.json` file

```json
{"statetimeseries":  { "key":  "weather", "states":  ["Fair", "Cloudy", "Sunny", "Rainy", "Stormy", "Snowy", "Windy", "Hail"], "displayname":  "Weather"}}
```

Reporting the state time series in the code is straightforward: 

```python
device.state_metric("weather", ship["weather"])
```

### Charts

So far we have not customized the look and feel of our ships in the Dynatrace interface.  
This can be done by adding key metrics, key chars and charts to the `plugin.json` `ui` section. 

#### Key metrics

A custom device can have up to four key metrics, add `fuel` and `thrust` metrics as key metrics.

```json
"keymetrics": [
      {"key":  "fuel", "displayName": "Fuel"},
      {"key":  "thrust", "displayName": "Thrust", "mergeaggregation": "AVG"}
],
```

#### Key charts

Key charts appear directly on the Custom Device screen.  
They cannot be split by `dimensions`, so you always have aggregated data.

```json
"keycharts": [
      {
        "group": "Performance",
        "title": "Fuel",
        "series": [
          {"key":  "fuel", "displayName": "Fuel", "seriestype":  "bar", "color": "#5ead35"}
        ]
      },
      {
        "group": "Performance",
        "title": "Thrust",
        "series": [
          {"key":  "thrust", "displayName": "Thrust", "mergeaggregation": "AVG"}
        ]
      },
      {
        "group": "Weather",
        "title": "Weather",
        "series": [
          {"key":  "weather", "displayName":  "Weather", "statechart":  true,
            "statecolors":  ["#ef651f", "#f5d30f", "#4fd5e0", "#4556d7", "#ffa86c", "#4556d7", "#ffa86c", "#4fd5e0"]}
        ]
      }
    ],
```

#### Charts

Charts appear when the user clicks `Further details` button in the Custom Device screen.   
They can be split by dimensions.

```json
"charts": [
      {
        "group": "Performance",
        "title": "Fuel",
        "series": [
          {"key":  "fuel", "displayName": "Fuel", "seriestype":  "bar", "color": "#5ead35"}
        ]
      },
      {
        "group": "Performance",
        "title": "Thrust",
        "series": [
          {"key":  "thrust", "displayName": "Thrust"}
        ]
      },
      {
        "group": "Weather",
        "title": "Weather",
        "series": [
          {"key":  "weather", "displayName":  "Weather", "statechart":  true,
            "statecolors":  ["#ef651f", "#f5d30f", "#4fd5e0", "#4556d7", "#ffa86c", "#4556d7", "#ffa86c", "#4fd5e0"]}
        ]
      }
    ]
```

### Files for version 1.003

#### plugin.json

```json
{
  "name": "custom.remote.python.spacex",
  "version": "1.003",
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
    {"timeseries":       { "key": "thrust", "unit": "Percent", "displayname": "Thrust", "dimensions": ["Engine"] }},
    {"statetimeseries":  { "key":  "weather", "states":  ["Fair", "Cloudy", "Sunny", "Rainy", "Stormy", "Snowy", "Windy", "Hail"], "displayname":  "Weather"}}
  ],
  "ui": {
    "keymetrics": [
      {"key":  "fuel", "displayName": "Fuel"},
      {"key":  "thrust", "displayName": "Thrust", "mergeaggregation": "AVG"}
    ],
    "keycharts": [
      {
        "group": "Performance",
        "title": "Fuel",
        "series": [
          {"key":  "fuel", "displayName": "Fuel", "seriestype":  "bar", "color": "#5ead35"}
        ]
      },
      {
        "group": "Performance",
        "title": "Thrust",
        "series": [
          {"key":  "thrust", "displayName": "Thrust", "mergeaggregation": "AVG"}
        ]
      },
      {
        "group": "Weather",
        "title": "Weather",
        "series": [
          {"key":  "weather", "displayName":  "Weather", "statechart":  true,
            "statecolors":  ["#ef651f", "#f5d30f", "#4fd5e0", "#4556d7", "#ffa86c", "#4556d7", "#ffa86c", "#4fd5e0"]}
        ]
      }
    ],
    "charts": [
      {
        "group": "Performance",
        "title": "Fuel",
        "series": [
          {"key":  "fuel", "displayName": "Fuel", "seriestype":  "bar", "color": "#5ead35"}
        ]
      },
      {
        "group": "Performance",
        "title": "Thrust",
        "series": [
          {"key":  "thrust", "displayName": "Thrust"}
        ]
      },
      {
        "group": "Weather",
        "title": "Weather",
        "series": [
          {"key":  "weather", "displayName":  "Weather", "statechart":  true,
            "statecolors":  ["#ef651f", "#f5d30f", "#4fd5e0", "#4556d7", "#ffa86c", "#4556d7", "#ffa86c", "#4fd5e0"]}
        ]
      }
    ]
  }
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

            # Add the topology information to the device
            device.add_endpoint(ship["ship_ip"])

            # Report properties
            device.report_property("Home port", ship.get("home_port", ""))
            device.report_property("Roles", ",".join(ship.get("roles", [])))

            # Send a state metric, state metrics can be strings!
            device.state_metric("weather", ship["weather"])

    def get_ships(self):
        return requests.get(self.config.get("url")).json()

```

### Test and deploy

Test and deploy your extension with `oneagent_sim` and `oneagent_build_plugin`