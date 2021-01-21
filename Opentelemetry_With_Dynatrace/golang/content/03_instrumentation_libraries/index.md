## Instrumentation Libraries
Compile Time instrumentation might be fun to some extent, but it's usually not your job to do that.
The idea behind OpenTelemetry is that third party software either already comes fully instrumented (with all the necessary source code for OpenTelemetry included) or alternatively is getting provided as an optional feature via a helper library.

### Prerequisites
- You have completed the previous task `Child Spans and Span Attributes`
- Shut down `fib.exe` using `Ctrl-C` within your Terminal if you haven't done so already.

### Step 1: Introduce OpenTelemetry via instrumentation library
- Lines 7 within `kafka.go` is the import of a helper library, that introduces OpenTelemetry on top of the already existing Kafka Client Library. Comment it in.
- Line 11 in `kafka.go` refers to the Kafka Broker that is supposed to receive messages. Replace it with the URL you've been given from your instructor at the beginning of this task.
- Line 35 in `kafka.go` represents the magic that's required to introduce OpenTelemetry Tracing capabilities to an existing Kafka Producer. Comment it in.
- Compile the program using the command line `go build -ldflags '-linkmode=external'`. This produces a file name `fib.exe` within the current directory.
- Launch `fib.exe` via your current Terminal
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service
- The PurePath you just created contains an additional PurePath Node for when the application reaches out to the Kafka Broker

### Step 2: Introduce OpenTelemetry via instrumentation library
- Investigate the additional PurePath Node. What additional data does it potentially offer?
- Introduce - like in Task 2 - the necessary configuration settings in order to capture that information
- Optionally you can also make that data available via Request Attribute

### You've arrived
- You have successfully instrumented Kafka Client communication without modifying the original library.
