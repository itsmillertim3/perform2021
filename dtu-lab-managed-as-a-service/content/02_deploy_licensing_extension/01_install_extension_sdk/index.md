## Install ActiveGate Extension SDK and deploy the extension

To get started, sign into your Dynatrace Managed cluster with an `admin` account and navigate to the *Licensing* environment created before. Follow steps below in order to download and install Environment ActiveGate.

### Step 1: Download ActiveGate Extension SDK 
1. Navigate to Settings > Monitoring > Monitored technologies > Add new technology monitoring 
1. Click *Add ActiveGate extension*.
1. Click *Download Extension SDK*.
1. Extract the archive to a convenient directory. It contains docs, examples, and the Extension SDK whl file you'll use to install the SDK.

### Step 2: Install ActiveGate Extension SDK
1. Navigate to the extracted directory with the whl file in it and run the following command:
    ```bash
    (activegate)$ pip3 install plugin_sdk-[sdk version number]-py3-none-any.whl
    ```
    For example:
    ```bash
    (activegate)$ pip3 install plugin_sdk-1.156.0.20181003.61122-py3-none-any.whl
    ```

1. To verify if the Extension SDK installation is successful, run:
    ```bash
    (activegate)$ plugin_sdk --help
    ```

### Step 2: Deploy the extension
You must upload the extension to both the Dynatrace Server and to the ActiveGate that will execute it. You have installed the Extension SDK on the ActiveGate host, so the `plugin_sdk build_plugin` command takes care of both the Server and ActiveGate.

The `plugin_sdk build_plugin` command builds the extension package and uploads it to a selected deployment directory. You'll need the Dynatrace Managed cluster URL and token to run the command. The SDK will automatically retrieve the Dynatrace Managed cluster URL from the ActiveGate configuration.

1. Download extension
1. Extract archive
1. Run the following command:
    ```bash
    (activegate)$ plugin_sdk build_plugin command
    ```
### Step 3: 

Congratulations, you have successfully deployed your first ActiveGate extension.

