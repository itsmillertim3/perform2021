## Install easyTravel

1. Install `easyTravel` by running the following commands:

    ```bash
    cd ~/easyTravel/
    ```

    ```bash
    java -jar dynatrace-easytravel-linux-x86_64.jar -y
    ```

    ```bash
    ./install_easytravel.sh
    ```

    **Note:** The easyTravel URL will be part of the script execution output.

1. Navigate to Technologies and filter by `Name: com.dynatrace.easytravel.weblauncher.jar easytravel-*-x*`.

1. click on the process group `com.dynatrace.easytravel.weblauncher.jar easytravel-*-x*`.

    ![et-launcher-disable](../../../assets/images/easytravel-launcher-pg.png)

1. Click on `Settings` on the top right section of the process group entity:

    ![et-launcher](../../../assets/images/easy-travel-launcher-process.png)

1. Disable monitoring for `com.dynatrace.easytravel.weblauncher.jar easytravel-*-x*`
    ![et-launcher-disable](../../../assets/images/easytravel-disable-launcher.png)