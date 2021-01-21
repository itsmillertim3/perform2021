package main

import (
	"go.opentelemetry.io/otel/api/global"
	"go.opentelemetry.io/otel/propagators"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
)

// initGlobalTracer has no documentation
func initGlobalTracer(providerOpts []sdktrace.TracerProviderOption) error {
	providerOpts = append(providerOpts, sdktrace.WithConfig(sdktrace.Config{DefaultSampler: sdktrace.AlwaysSample()}))

	tp := sdktrace.NewTracerProvider(providerOpts...)
	global.SetTracerProvider(tp)

	global.SetTextMapPropagator(propagators.TraceContext{})
	return nil
}
