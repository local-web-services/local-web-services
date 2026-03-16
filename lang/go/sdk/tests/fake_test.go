package tests

import (
	"github.com/cucumber/godog"
)

// registerFakeSteps registers fake response step definitions.
// All fake scenarios are marked pending because the Go core in-process server
// does not implement /_ldk/aws-fake. Fake functionality requires the ldk dev process.
func registerFakeSteps(sc *godog.ScenarioContext, world *World) {
	sc.When(`^I configure a fake success response for "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.When(`^I configure a fake success response for "([^"]*)" "([^"]*)" with a (\d+)ms delay$`, func(service, operation string, delayMs int) error {
		_ = world
		return godog.ErrPending
	})

	sc.When(`^I configure a fake error "([^"]*)" for "([^"]*)" "([^"]*)"$`, func(errorCode, service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.Given(`^a running session with a fake success response on "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.When(`^I clear fakes for "([^"]*)"$`, func(service string) error {
		_ = world
		return godog.ErrPending
	})

	sc.Step(`^I call "([^"]*)" "([^"]*)" against a real state machine$`, func(service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.Then(`^the faked response body is returned$`, func() error {
		return godog.ErrPending
	})

	sc.Then(`^the real response is returned$`, func() error {
		return godog.ErrPending
	})
}
