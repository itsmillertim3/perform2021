## Producing a simple Span and report it to Dynatrace
In this step we extend a sample program with an additional OpenTelemetry Span.
The sample consists of an HTTP Server which is able to calculate any Fibonacci number. 

### Prerequisites
- OneAgent is already installed on your Workstation
- OpenTelemetry instrumentation for Golang has been enabled for your Dynatrace Environment (`Settings` > `Server-side service monitoring` > `Deep Monitoring` > `OpenTelemetry and OpenTracing`)

### Step 1: Compile and launch the program
- In Visual Studio Code open up a Terminal
- Compile the program using the command line `go build -ldflags '-linkmode=external'`. This produces a file name `fib.exe` within the current directory.
- Launch `fib.exe` via your current Terminal. Windows Security likely will ask you to confirm, that this program is allowed to listen on incoming socket connections.
- In your Dynatrace Environment navigate to `Hosts` and select the Workstation you're working on
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service
- Wait until `fib.exe` shows up among the Processes on this host
- Dynatrace by default has decided to disable monitoring for this executable (`Process isn't monitored`). Click on the link `monitored technologies` and override the defaults for this Process Group. 
- Within your Terminal press `Ctrl-C` to shut down `fib.exe`. Launch `fib.exe` again. 
- Dynatrace in some cases tells you afterwards that this process needs to get restarted yet another time. Within your Terminal press `Ctrl-C` to shut down `fib.exe`. Launch `fib.exe` again. 
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service

### Step 2: Introduce OpenTelemetry to your Application
- Lines 4, 9 and 10 in `main.go` represent the imports for OpenTelemetry packages. They are currently commented out. Comment them in.
- Lines 14-16 in `main.go` are required to initialize OpenTelemetry and configure a minimal Span Exporter. Comment them in.
- Lines 34-50 in `main.go` will replace our existing function `FibServer`. It is safe to delete the existing function and comment lines 34-50 instead.
- Compile the program using the command line `go build -ldflags '-linkmode=external'`. This produces a file name `fib.exe` within the current directory.
- Launch `fib.exe` via your current Terminal
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service

### You've arrived
- The PurePath you just created now contains an additional PurePath Node created via OpenTelemetry
