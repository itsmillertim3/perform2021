## Lab Setup

In this lab we will run  the scripts to install the packages and create configurations needed.

1. Install required packages:

    ```bash
    cd ~/scripts/
    ```

    ```bash
    ./install_packages.sh && logout
    ```

1. Log back into the ubuntu server with your username and password.

1. Create the extra vars file (HAProxy IP address will be provided by the instructor):

    ```bash
    cd ~
    ```

    ```bash
    ./define_credentials.sh
    ```
