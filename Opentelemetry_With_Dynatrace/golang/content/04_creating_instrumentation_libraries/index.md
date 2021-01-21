## Creating Instrumentation Libraries
With Task 2 we actually overshot. First of all, we had to modify the existing source code of the Fibonacci Calculator. This is rarely possible for third party libraries.
Second, our solution traces ALL the invocations of the `Calc` function. Trace sizes easily explode given a sufficiently high input value.

### Prerequisites
- You have completed the previous task `Instrumentation Libraries`
- Shut down `fib.exe` using `Ctrl-C` within your Terminal if you haven't done so already.

### Step 1: Restore the original Fibonacci Calculator and create a Wrapper
- The current code within `fibonacci.go` is obsolete.
- We are replacing it with the remaining code that is still commented out (look for `// LESSON 4: Creating Instrumentation Libraries`)
- Compile the program using the command line `go build -ldflags '-linkmode=external'`. This produces a file name `fib.exe` within the current directory.
- Launch `fib.exe` via your current Terminal
- Use either your Browser or `curl http://localhost:28080/fib?n=3` within a new Terminal to access your new HTTP Service

### You've arrived
- The PurePath you just created does no longer report a Span for every single invocation of the function `Calc`. Most importantly the code of the original Fibonacci Calculator remains untouched. You've managed to create an instrumentation library that performs the necessary work.
