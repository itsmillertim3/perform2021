## Using OpenTracing instrumentation libaries
In this step we extend the Java SpringBoot application with an available OpenTracing instrumentation libary.

### Step 1: Decorate the java code with the HazelCast OpenTracing libaries
- Open `CommandController.java`
- Import the OpenTracing Libraries - Comment line 3 and 7
- Initialze the OpenTracing [GlobalTracer](https://github.com/opentracing/opentracing-java/blob/master/opentracing-util/src/main/java/io/opentracing/util/GlobalTracer.java) - Comment line 28 and 32
- Enhanc HazelcastInstance with [TracingHazelcastInstance](https://github.com/opentracing-contrib/java-hazelcast) - Comment line 35 and 42
- Save the file `CTRL+S`

### Step 2: Compile and run the application
- Run this command `mvn spring-boot:run`
- Check that the program compiles without any errors and it connects to the HazelCast nodes

### Step 3: Populate the HazelCast instance with new entries and retrieve the data
- Enter `curl http://localhost:8080/pop2`

```powershell
PS C:\Users\dtu.training\Documents\opentracing-hazelcast> curl http://localhost:8080/pop2

StatusCode        : 200
StatusDescription :
Content           : {"response":"100 entries inserted to the map with key: <your public ip>-* , starting from 200 "}
...
```
- Retrieve the data with the key format as `<your public ip>-200`, example:

```powershell
PS C:\Users\dtu.training\Documents\opentracing-hazelcast> http://localhost:8080/get?key=1.2.3.4-200

StatusCode        : 200
StatusDescription :
Content           : {"response":"1.2.3.4-200"}
...
```
- Execute a few more `get` transactions with different keys

### Step 4: Explore Dynatrace PurePaths after implementing OpenTracing libaries 
- Access your Dynatrace tenant in the browser
- Go to Transactions and Services > CommandController > Purepaths
- Choose the /pop2 transaction
- You will observe that we are getting more visibility into the application execution