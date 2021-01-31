## Deploy the Licensing ActiveGate Extension
Typically, you must upload the extension to both Dynatrace cluster nodes and to the ActiveGate that will execute it. However, in this activity we'll use a pre-installed Extension SDK on the ActiveGate host, so the `plugin_sdk build_plugin` command takes care of both the Server and ActiveGate. 

### Step 1: Generate the token to deploy the extension
In the `Licensing` environment, navigate to **Settings** > **Integration** > **Dynatrace API**.

1. Click **Generate token** button.
1. Type a token name. For example: `Licensing AG Extension`
1. Turn on **Write configuration** (API v1) access scope.
1. Click **Generate**.
1. Click **Copy** to get and store the token in your notes. You'll not be able to see the token value again.
1. Click **Close** to finish the token generation task.

### Step 2: Download the extension

To deploy the extension follow this procedure:
1. Download extension:
    ```bash
    (activegate)$ wget https://github.com/Dynatrace/perform-2021-hotday/raw/main/dtu-lab-managed-as-a-service/assets/extension/licensing-extension.zip
    ```
1. Extract the archive:
    ```bash
    (activegate)$ unzip licensing-extension.zip
    ```
1. Navigate to the extracted director
    ```bash
    (activegate)$ cd licensing-extension
    ```

### Step 3: Deploy the extension
1. The command builds the extension package and uploads it to a selected deployment directory:
    ```bash
    (activegate)$ sudo plugin_sdk build_plugin
    ```

1. You'll be asked to input the token with:
    ```
    Does token file exist? (Y or N; default is Y): 
    ```

    Type `N`.

1. Follow with entering the token, we've created in the previous step:
    ```
    Enter authentication token: <TYPE TOKEN HERE>
    ```

If above procedure finishes successfully you should see:
```
plugin has been uploaded successfully
```

Congratulations, you have successfully deployed the Licensing ActiveGate extension. Proceed to the next activity step to configure the extension.