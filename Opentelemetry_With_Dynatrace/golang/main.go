package main

import (
	// "context"
	"fib/fibonacci"
	"fib/kafka"
	"fmt"
	"net/http"
	// "go.opentelemetry.io/otel/api/global"
	// "go.opentelemetry.io/otel/api/trace"
)

func main() {
	// if err := initGlobalTracer(nil); err != nil {
	// 	panic(err)
	// }
	http.HandleFunc("/fib", FibServer)
	http.HandleFunc("/favicon.ico", faviconHandler)
	http.ListenAndServe(":28080", nil)
}

// FibServer handles HTTP requests for fibonacci calculation
func FibServer(w http.ResponseWriter, r *http.Request) {
	if n, err := getIntParam(r); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
	} else {
		result := fibonacci.New().Calc(n)
		kafka.Send(result)
		w.Write([]byte(fmt.Sprintf("%d", result)))
	}
}

/*
// FibServer handles HTTP requests for fibonacci calculation
func FibServer(w http.ResponseWriter, r *http.Request) {
	tracer := global.Tracer("http")
	ctx := context.Background()

	var span trace.Span
	ctx, span = tracer.Start(ctx, "http-request")
	defer span.End()

	if n, err := getIntParam(r); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
	} else {
		result := fibonacci.New().Calc(n)
		kafka.Send(result)
		w.Write([]byte(fmt.Sprintf("%d", result)))
	}
}
*/

/*
// FibServer handles HTTP requests for fibonacci calculation
func FibServer(w http.ResponseWriter, r *http.Request) {
	tracer := global.Tracer("http")
	ctx := context.Background()

	var span trace.Span
	ctx, span = tracer.Start(ctx, "http-request")
	defer span.End()

	if n, err := getIntParam(r); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
	} else {
		result := fibonacci.New(ctx).Calc(n)
		kafka.Send(result)
		w.Write([]byte(fmt.Sprintf("%d", result)))
	}
}
*/

/*
// FibServer handles HTTP requests for fibonacci calculation
func FibServer(w http.ResponseWriter, r *http.Request) {
	tracer := global.Tracer("http")
	ctx := context.Background()

	var span trace.Span
	ctx, span = tracer.Start(ctx, "http-request")
	defer span.End()

	if n, err := getIntParam(r); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
	} else {
		result := fibonacci.Wrap(ctx, fibonacci.New()).Calc(n)
		kafka.Send(result)
		w.Write([]byte(fmt.Sprintf("%d", result)))
	}
}
*/
