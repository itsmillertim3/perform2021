package fibonacci

// import (
// 	"context"
// 	"fmt"

// 	"go.opentelemetry.io/otel/api/global"
// 	"go.opentelemetry.io/otel/api/trace"
// 	"go.opentelemetry.io/otel/label"
// )

// Fibonacci calculates fibonacci numbers
type Fibonacci interface {
	Calc(n int) int // Calc has no documentation
}

// New creates a new Fibonacci Calculator
func New() Fibonacci {
	return &fibonacci{}
}

type fibonacci struct{}

// Calc calculates the n-th fibonacci number
func (f *fibonacci) Calc(n int) int {
	if n < 3 {
		return 1
	}
	return f.Calc(n-1) + f.Calc(n-2)
}

/*
// LESSON 2: Child Spans and Span Attributes

// New creates a new Fibonacci Calculator
func New(ctx context.Context) Fibonacci {
	return &fibonacci{Context ctx}
}

type fibonacci struct {
	Context context.Context
}

// Calc calculates the n-th fibonacci number
func (f *fibonacci) Calc(n int) int {
	var span trace.Span
	tracer := global.Tracer("")
	f.Context, span = tracer.Start(f.Context, fmt.Sprintf("fib(%d)", n))
	defer span.End()

	if n < 3 {
		span.SetAttributes(label.Key("fib.result").Int(1))
		return 1
	}
	result := f.Calc(n-1) + f.Calc(n-2)
	span.SetAttributes(label.Key("fib.result").Int(result))
	return result
}

// LESSON 2: Child Spans and Span Attributes
*/

/*
// LESSON 4: Creating Instrumentation Libraries

// Fibonacci calculates fibonacci numbers
type Fibonacci interface {
	Calc(n int) int // Calc has no documentation
}

// New creates a new Fibonacci Calculator
func New() Fibonacci {
	return &fibonacci{}
}

type fibonacci struct{}

// Calc calculates the n-th fibonacci number
func (f *fibonacci) Calc(n int) int {
	if n < 3 {
		return 1
	}
	return f.Calc(n-1) + f.Calc(n-2)
}

// Wrap produces a Fibonacci Calculator with tracing capabilities
func Wrap(ctx context.Context, f Fibonacci) Fibonacci {
	return &tracingFib{Context: ctx, Fibonacci: f}
}

type tracingFib struct {
	Fibonacci Fibonacci
	Context   context.Context
}

func (tf *tracingFib) Calc(n int) int {
	var span trace.Span
	tracer := global.Tracer("")
	tf.Context, span = tracer.Start(tf.Context, fmt.Sprintf("fib(%d)", n))
	defer span.End()
	result := tf.Fibonacci.Calc(n)
	span.SetAttributes(label.Key("fib.result").Int(result))
	return result
}
// LESSON 4: Creating Instrumentation Libraries
*/
