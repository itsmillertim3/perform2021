## Capture Application Data with the CICS SDK

In this module you will learn how to capture application data using the SDK and making it available in Dynatrace.

### Step 1: Prepare your COBOL application program
- Edit member ADKCOBOL in `<userid>.JCL`
- Uncomment the following lines in the source code (between *===========================)
```COBOL
Call "DTDCTF" Using ARGUMENT, ARGLEN, ARGCCSID Returning RC.
If RC Not Equal ZERO                                        
    MOVE "DTDCTF" to MSG_API                                
    MOVE RC to MSG_RC                                       
    EXEC CICS WRITE OPERATOR TEXT(ERROR_MSG) END-EXEC.      
```
	
### Step 2: Define Request Attribute for your Mainframe Data
- Go to your Dynatrace Tenant
- Select `Settings->Server Side Service Monitoring->Request Attributes`
- ...

### Step 3: Trigger some test transactions
- Go to ISPF

### Step 4: Verify Request Attributes in Dynatrace
- ...

### You've arrived
- You have successfuly instrumented your application to capture Mainframe application data and are now able to use it as Request Attribute! 





