package tests

import (
	"fmt"
	"strings"

	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

func registerChaosSteps(sc *godog.ScenarioContext, world *World) {
	// Given a running session with 100% error rate on "stepfunctions"
	sc.Given(`^a running session with 100% error rate on "([^"]*)"$`, func(service string) error {
		world.sessionOpen = true
		return core.ChaosSet(world.managementPort, service, 1.0, 0, 0)
	})

	// When I set a 100% error rate on "stepfunctions"
	sc.When(`^I set a 100% error rate on "([^"]*)"$`, func(service string) error {
		return core.ChaosSet(world.managementPort, service, 1.0, 0, 0)
	})

	// When I clear chaos for "stepfunctions"
	sc.When(`^I clear chaos for "([^"]*)"$`, func(service string) error {
		return core.ChaosDisable(world.managementPort, service)
	})

	// When I call "service" "Operation"
	sc.When(`^I call "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		return dispatchServiceCall(world, service, operation)
	})

	// Then an AWS error is returned
	sc.Then(`^an AWS error is returned$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected an AWS error but call succeeded")
		}
		return nil
	})

	// Then the call succeeds
	sc.Then(`^the call succeeds$`, func() error {
		if !world.lastResult.Success {
			return fmt.Errorf("expected the call to succeed but got error: %v", world.lastResult.Error)
		}
		return nil
	})

	// Then an AWS error "<code>" is returned
	sc.Then(`^an AWS error "([^"]*)" is returned$`, func(errorCode string) error {
		if world.lastResult.Success {
			return fmt.Errorf("expected an AWS error %q but call succeeded", errorCode)
		}
		errStr := fmt.Sprintf("%v", world.lastResult.Error)
		if !strings.Contains(errStr, errorCode) {
			return fmt.Errorf("expected error to contain %q but got: %s", errorCode, errStr)
		}
		return nil
	})

	// Then an IAM access denied error is returned
	sc.Then(`^an IAM access denied error is returned$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected an IAM access denied error but call succeeded")
		}
		errStr := fmt.Sprintf("%v", world.lastResult.Error)
		if !strings.Contains(errStr, "AccessDenied") &&
			!strings.Contains(errStr, "NotAuthorized") &&
			!strings.Contains(errStr, "403") &&
			!strings.Contains(errStr, "access denied") {
			return fmt.Errorf("expected IAM access denied error but got: %s", errStr)
		}
		return nil
	})
}
