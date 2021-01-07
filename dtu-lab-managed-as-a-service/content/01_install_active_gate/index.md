## Install Environment ActiveGate

In this step, we're going to install Environment ActiveGate. It is required to deploy an ActiveGate extension in the next activity step.

To get started, sign into your Dynatrace Managed cluster with an `admin` account and navigate to the *Licensing* environment created before. Follow steps below in order to download and install Environment ActiveGate.

### Step 1: Start installation

1. Select *Deploy Dynatrace* from the navigation menu
1. Select *Install ActiveGate*. 
1. Select the *Linux* platform.

### Step 2: Download the Environment ActiveGate installer
1. Select the purpose: *Route OneAgent traffic to Dynatrace, monitor cloud environments, or monitor remote technologies with extensions*
1. Copy the wget command line from the text box, and paste the command into your terminal window on a machine. Make sure you copy the command directly from the first text box, because it contains your environment ID.
1. Verify the signature
Wait for the download to complete. Then verify the signature by copying the command from the second *Verify signature* text box and pasting the command into your terminal window.


### Step 3: Run the installer
An install parameter is automatically set for the command to run the installer. Make sure you use the command displayed in the Dynatrace web UI that reflects the ActiveGate purpose.

1. To install ActiveGate, run one of the following commands in the directory where you downloaded the installation script.

   ```bash
   (activegate)$ chmod +x Dynatrace-ActiveGate-Linux-x86-1.0.0.sh
   ```

1. Copy the installation script command from the *Run the installer with root rights* step and paste it into your terminal.

### You've arrived 
After Environment ActiveGate connects to Dynatrace, installation is complete.

To check the status of the installation, click Show deployment status and select the Dynatrace ActiveGates tab. You can learn more about [Dynatrace Active Gate](https://www.dynatrace.com/support/help/shortlink/activegate-hub) at Dynatrace Help.