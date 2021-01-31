## Install ActiveGate Extension SDK

### Step 1: Download ActiveGate Extension SDK 
1. Download the archive:
    ```bash
    (activegate)$ wget https://github.com/Dynatrace/perform-2021-hotday/raw/main/dtu-lab-managed-as-a-service/assets/extension/plugin-sdk-1.207.233.20210118-133635.zip
    ```
1. Extract the archive. It contains docs, examples, and the Extension SDK whl file you'll use to install the SDK. Run the following command:
    ```bash
    (activegate)$ unzip plugin-sdk-1.207.233.20210118-133635.zip
    ```

### Step 2: Install ActiveGate Extension SDK
1. Run the following command:
    ```bash
    (activegate)$ sudo pip3 install plugin_sdk-1.207.233.20210118.133635-py3-none-any.whl
    ```

1. To verify if the Extension SDK installation is successful, run:
    ```bash
    (activegate)$ plugin_sdk --version
    ```

You should see "`plugin_sdk 1.207.233.20210118.133635`" as an output. Now, you are able to proceed to the next step.