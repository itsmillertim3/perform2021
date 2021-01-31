## Project Creation

### Development strategy

A python extension needs at least two files:

* A python file that contains our logic
* The `plugin.json` file, with contains metrics/charts/properties and some extension metadata.


#### Project creation and structure

1. Create a new empty folder for our project, open it with vscode
   * *Best practice is to use a virtual environment for every project, not necessary for the lab*
2. Create a `src` folder in the root, this will hold our source code
3. Create a `built` folder in the root, this will hold the built extension, that we can later distribute for other users
4. Create two files inside the `src` folder:
   * `spacex_extension.py`
   * `plugin.json`
   

#### Plugin.json

The `plugin.json` file contains extension metadata.
The most basic content of this file is below, you can copy and paste this content:

```json
{
  "name": "custom.remote.python.spacex",
  "version": "1.001",
  "metricGroup": "tech.SpaceX",
  "technologies": ["SpaceX"],
  "type": "python",
  "entity": "CUSTOM_DEVICE",
  "source": {
    "package": "spacex_extension",
    "className": "SpaceXExtension",
    "install_requires": []
  },
  "properties": [],
  "configUI": {
    "displayName": "SpaceX",
    "properties": []
  },
  "metrics": []
}
```

### Python code

The `spacex_extension.py` will hold our logic.  
The file contains a single class, which must extend `RemoteBasePlugin` and implement a `query` method, which will be run every minute by the extension framework.
  
  
The minimum content of the file for a working plugin is:

```python
from ruxit.api.base_plugin import RemoteBasePlugin


class SpaceXExtension(RemoteBasePlugin):

    def query(self, **kwargs):
        pass

```

