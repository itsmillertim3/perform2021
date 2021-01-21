## Child Spans and Span Attributes
The OpenTelemetry Span we just created is more or less redundant. The HTTP Sensor of Dynatrace already created the necessary PurePath Node. Whatever we have introduced via OpenTelemetry doesn't really enrich our experience.
In this task our goal is to grant users of Dynatrace deeper insight into what is going on when the Fibonacci number is getting calculated.

### Prerequisites
- You have completed the previous task `Producing a simple Span and report it to Dynatrace`
- Shut down `fib.exe` using `Ctrl-C` within your Terminal if you haven't done so already.

### Step 1: Introduce OpenTelemetry functionality into the Fibonacci function
- Lines 3-10 in `fibonacci.go` represent the necessary package imports in order to use the OpenTelemetry API. Comment them in.
- Lines 17-30 in `fibonacci.go` are the current implementation for the Fibonacci Calculator. It is safe to delete this section and instead you should comment in lines 32-61.
- Compile the program using the command line `go build -ldflags '-linkmode=external'`. This produces a file name `fib.exe` within the current directory.
- Launch `fib.exe` via your current Terminal
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service
- The PurePath you just created now contains an additional PurePath Node per invocation of the Fibonacci Calculator's `Calc` function.

### Step 2: Tell Dynatrace which OpenTelemetry Attributes are of interest for you
- In Dynatrace navigate to `Settings` > `Server-side service monitoring` > `Span Attributes`. Add an additional item here. The key you want Dynatrace to capture is `fib.result`.
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service

### Step 2: Capture a Request Attribute based on the OpenTelemetry Key
- In Dynatrace navigate to `Settings` > `Server-side service monitoring` > `Request Attributes`.
- The Data Source for our Request Attribute needs to be a `Span Attribute`.
- The Key of the Request Attribute is called `fib.result` (unless you have chosen a different name)
- We are just interested in the last value within the PurePath - any intermediate results should be ignored.
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service

### You've arrived
- The PurePath you just created now contains an additional PurePath Node per invocation of the Fibonacci Calculator's `Calc` function. In addition the Request Attribute you just created is also available on every PurePath.
