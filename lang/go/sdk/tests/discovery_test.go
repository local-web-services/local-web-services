package tests

import (
	"github.com/cucumber/godog"
)

func registerDiscoverySteps(sc *godog.ScenarioContext, world *World) {
	// CDK discovery feature — mark as pending
	sc.When(`^I create a session from the "([^"]*)" CDK directory$`, func(dir string) error {
		world.sessionOpen = true
		return godog.ErrPending
	})

	sc.Then(`^the resources declared in the CDK stack are available$`, func() error {
		return godog.ErrPending
	})

	// HCL discovery feature — mark as pending
	sc.When(`^I create a session from the "([^"]*)" HCL directory$`, func(dir string) error {
		world.sessionOpen = true
		return godog.ErrPending
	})

	sc.Then(`^the resources declared in the HCL are available$`, func() error {
		return godog.ErrPending
	})
}
