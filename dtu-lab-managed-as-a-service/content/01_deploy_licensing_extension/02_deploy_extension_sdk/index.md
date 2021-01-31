## Deploy the Licensing ActiveGate Extension
Typically, you must upload the extension to both Dynatrace cluster nodes and to the ActiveGate that will execute it. However, in this activity we'll use a pre-installed Extension SDK on the ActiveGate host, so the `plugin_sdk build_plugin` command takes care of both the Server and ActiveGate. 

### Step 1: Download the extension

To deploy the extension follow this procedure:
1. Download extension:
    ```bash
    (activegate)$ wget https://github.com/Dynatrace/perform-2021-hotday/raw/main/dtu-lab-managed-as-a-service/assets/extension/custom.remote.python.host_unit.zip
    ```
1. Extract the archive:
    ```bash
    (activegate)$ unzip custom.remote.python.host_unit.zip
    ```
1. Navigate to the extracted director
    ```bash
    (activegate)$ cd custom.remote.python.host_unit
    ```

### Step 2: Deploy the extension
The command builds the extension package and uploads it to a selected deployment directory:
```bash
(activegate)$ plugin_sdk build_plugin
```

If above procedure finishes successfully you should see:
```
plugin has been uploaded successfully
```

Congratulations, you have successfully deployed the Licensing ActiveGate extension. Proceed to the next activity step to configure the extension.