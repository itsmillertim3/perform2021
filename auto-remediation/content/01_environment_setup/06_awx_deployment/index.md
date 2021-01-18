## Deploy ansible AWX

1. Deploy `Ansible AWX` using the commands below:

    ```bash
    cd ~/scripts/
    ```

    ```bash
    ./install_awx.sh
    ```

    **Note:** The AWX URL and login details will be part of the script execution output.

1. Save the AWX URL, credentials and the remediation template ID as they will be necessary on the upcoming labs.

1. (Optional) Navigate to `Settings -> Miscellaneous System` and click on the `Edit` button on the bottom left to increase the `Idle Time Force Log Out` seconds to 50000.