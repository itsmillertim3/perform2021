## Create Connection Aliases

### Create Basic Auth Credential

1. Navigate to `Integration Hub -> Connections & Credentials -> Credential` and click on `New`:

    ![service-now-cred](../../../assets/images/service-now-cred.png)

1. Select `Basic Auth Credentials`

1. Set the following values for the credential fields:

    - **Name:** AWX Basic Auth
    - **User name:** admin
    - **Password:** dynatrace

    ![service-now-credential](../../../assets/images/service-now-credential.png)

1. Click `Submit`.

### Create Connection Alias

1. Navigate to `Integration Hub -> Connections & Credentials -> Connection & Credential Aliases` and click on the `Ansible AWX` Connection Alias:

    ![service-now-conn-alias](../../../assets/images/service-now-conn-alias.png)

1. Under the `Connections` related list, click on `New`:

    ![service-now-conn-alias-details](../../../assets/images/service-now-conn-alias-details.png)

1. Set the `Connection` fields to these values:
    - **Name:** AWX Basic Auth
    - **Credential:** admin
    - **Connection alias:** dynatrace
    - **Connection URL:** your ansible AWX url - `https://XX.XX.XX.XX`

    ![servicenow-connection-details](../../../assets/images/servicenow-connection-details.png)

1. Click `Submit`.

### Disable SSL verification in ServiceNow Instance

Since we'll be using self-signed certificates, we'll need to add/update system properties in ServiceNow to ignore any untrusted certificates and hosts.

1. On the ServiceNow filter navigator enter `sys_properties.list` and press `Enter/return` on your keyboard:

    ![servicenow_sys_properties](../../../assets/images/servicenow_sys_properties.png)

1. Update/create the following properties with their respective values:
    - **com.glide.communications.httpclient.verify_revoked_certificate:** false
    - **com.glide.communications.trustmanager_trust_all:** true
    - **com.glide.communications.httpclient.verify_hostname:** false

    ![servicenow_sys_properties_values](../../../assets/images/servicenow_sys_properties_values.png)
