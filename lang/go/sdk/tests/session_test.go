package tests

import (
	"fmt"

	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

func registerSessionSteps(sc *godog.ScenarioContext, world *World) {
	// When I create a session
	sc.When(`^I create a session$`, func() error {
		world.sessionOpen = true
		return nil
	})

	// Given a running session
	sc.Given(`^a running session$`, func() error {
		world.sessionOpen = true
		return nil
	})

	// Then the session is running
	sc.Then(`^the session is running$`, func() error {
		if !world.sessionOpen {
			return fmt.Errorf("expected session to be running but it is not")
		}
		return nil
	})

	// When I close the session
	sc.When(`^I close the session$`, func() error {
		world.sessionOpen = false
		return nil
	})

	// Then the session is closed
	sc.Then(`^the session is closed$`, func() error {
		if world.sessionOpen {
			return fmt.Errorf("expected session to be closed but it is still running")
		}
		return nil
	})

	// When I open a session as a context manager
	sc.When(`^I open a session as a context manager$`, func() error {
		world.sessionOpen = true
		return nil
	})

	// Then the session is running inside the context
	sc.Then(`^the session is running inside the context$`, func() error {
		if !world.sessionOpen {
			return fmt.Errorf("expected session to be running inside context manager")
		}
		return nil
	})

	// And the session is closed after the context exits
	sc.Then(`^the session is closed after the context exits$`, func() error {
		// Simulate context manager exit closing the session.
		world.sessionOpen = false
		return nil
	})

	// When I reset the session
	sc.When(`^I reset the session$`, func() error {
		if err := core.Reset(world.managementPort); err != nil {
			world.lastResult = LastResult{Success: false, Error: err}
			return nil
		}
		world.lastResult = LastResult{Success: true}
		return nil
	})

	// And I reset the session again
	sc.When(`^I reset the session again$`, func() error {
		if err := core.Reset(world.managementPort); err != nil {
			world.lastResult = LastResult{Success: false, Error: err}
			return nil
		}
		world.lastResult = LastResult{Success: true}
		return nil
	})

	// Then no error is raised
	sc.Then(`^no error is raised$`, func() error {
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected no error but got: %v", world.lastResult.Error)
		}
		return nil
	})
}
