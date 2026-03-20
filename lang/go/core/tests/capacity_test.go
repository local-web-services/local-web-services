package tests

import (
	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

func registerCapacitySteps(sc *godog.ScenarioContext, world *World) {
	// Given steps for capacity state

	sc.Given(`^the execution slot is not available$`, func() error {
		return lws.CapacityExhaust(world.managementPort, "stepfunctions")
	})

	sc.Given(`^the execution slot is available$`, func() error {
		return lws.CapacityUnlimited(world.managementPort, "stepfunctions")
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		return lws.CapacityExhaust(world.managementPort, "lambda")
	})

	sc.Given(`^no request slot is available$`, func() error {
		return lws.CapacityExhaust(world.managementPort, "apigateway")
	})

	sc.Given(`^a request slot is available$`, func() error {
		return lws.CapacityUnlimited(world.managementPort, "apigateway")
	})

	sc.Given(`^no item slot is available$`, func() error {
		return lws.CapacityExhaust(world.managementPort, "dynamodb")
	})

	sc.Given(`^no document slot is available$`, func() error {
		return lws.CapacityExhaust(world.managementPort, "opensearch")
	})
}
