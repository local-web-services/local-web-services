package tests

import (
	"fmt"
	"time"

	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)

// pollForEntry waits up to 5 seconds for a log entry matching service and operation.
// operation may be empty to match any operation for the service.
func pollForEntry(capture *lws.LogCapture, service, operation string) bool {
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		for _, e := range capture.Entries() {
			if e.Service == service && (operation == "" || e.Operation == operation) {
				return true
			}
		}
		time.Sleep(50 * time.Millisecond)
	}
	return false
}

// registerLogsSteps registers log capture step definitions.
func registerLogsSteps(sc *godog.ScenarioContext, world *World) {
	sc.When(`^I start log capture and call "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		// Arrange
		sess := managementSession()

		// Act — start capture then make the call
		capture, err := sess.StartLogCapture()
		if err != nil {
			return fmt.Errorf("start log capture: %w", err)
		}
		world.lastLogCapture = capture

		return dispatchServiceCall(world, service, operation)
	})

	sc.Then(`^the log capture will contain a "([^"]*)" "([^"]*)" entry$`, func(service, operation string) error {
		// Assert
		if world.lastLogCapture == nil {
			return fmt.Errorf("no log capture was started")
		}
		if !pollForEntry(world.lastLogCapture, service, operation) {
			return fmt.Errorf("log capture: expected call to %s/%s but none was recorded after 5s", service, operation)
		}
		return nil
	})

	sc.Then(`^no errors will appear in the log capture$`, func() error {
		// Assert
		if world.lastLogCapture == nil {
			return fmt.Errorf("no log capture was started")
		}
		// Allow a brief settling window
		time.Sleep(100 * time.Millisecond)
		for _, e := range world.lastLogCapture.Entries() {
			if e.StatusCode >= 500 {
				return fmt.Errorf("unexpected error entry: service=%s operation=%s status=%d",
					e.Service, e.Operation, e.StatusCode)
			}
		}
		return nil
	})

	sc.When(`^I start log capture and call both "([^"]*)" "([^"]*)" and "([^"]*)" "([^"]*)"$`,
		func(svc1, op1, svc2, op2 string) error {
			// Arrange
			sess := managementSession()

			// Act
			capture, err := sess.StartLogCapture()
			if err != nil {
				return fmt.Errorf("start log capture: %w", err)
			}
			world.lastLogCapture = capture

			if err := dispatchServiceCall(world, svc1, op1); err != nil {
				return err
			}
			return dispatchServiceCall(world, svc2, op2)
		})

	sc.Then(`^filtering by service "([^"]*)" returns only ([^ ]+) entries$`, func(filterService, _ string) error {
		// Assert
		if world.lastLogCapture == nil {
			return fmt.Errorf("no log capture was started")
		}
		// Wait for at least one entry for this service
		if !pollForEntry(world.lastLogCapture, filterService, "") {
			return fmt.Errorf("no entries found for service %q after 5s", filterService)
		}
		entries := world.lastLogCapture.ForService(filterService)
		if len(entries) == 0 {
			return fmt.Errorf("ForService(%q) returned no entries", filterService)
		}
		for _, e := range entries {
			if e.Service != filterService {
				return fmt.Errorf("ForService(%q) returned entry with service %q", filterService, e.Service)
			}
		}
		return nil
	})

	sc.Then(`^filtering by operation "([^"]*)" returns at least one entry$`, func(operation string) error {
		// Assert
		if world.lastLogCapture == nil {
			return fmt.Errorf("no log capture was started")
		}
		deadline := time.Now().Add(5 * time.Second)
		for time.Now().Before(deadline) {
			if len(world.lastLogCapture.ForOperation(operation)) > 0 {
				return nil
			}
			time.Sleep(50 * time.Millisecond)
		}
		return fmt.Errorf("ForOperation(%q) returned no entries after 5s", operation)
	})

	sc.When(`^I start log capture and call "([^"]*)" "([^"]*)" twice$`, func(service, operation string) error {
		// Arrange
		sess := managementSession()

		// Act
		capture, err := sess.StartLogCapture()
		if err != nil {
			return fmt.Errorf("start log capture: %w", err)
		}
		world.lastLogCapture = capture

		if err := dispatchServiceCall(world, service, operation); err != nil {
			return err
		}
		return dispatchServiceCall(world, service, operation)
	})

	sc.Then(`^the log capture will contain exactly (\d+) "([^"]*)" "([^"]*)" entries$`, func(expected int, service, operation string) error {
		// Assert — poll up to 5s for the expected count
		if world.lastLogCapture == nil {
			return fmt.Errorf("no log capture was started")
		}
		deadline := time.Now().Add(5 * time.Second)
		for time.Now().Before(deadline) {
			count := 0
			for _, e := range world.lastLogCapture.Entries() {
				if e.Service == service && e.Operation == operation {
					count++
				}
			}
			if count == expected {
				return nil
			}
			time.Sleep(50 * time.Millisecond)
		}
		count := 0
		for _, e := range world.lastLogCapture.Entries() {
			if e.Service == service && e.Operation == operation {
				count++
			}
		}
		return fmt.Errorf("expected %d %s/%s entries but got %d after 5s", expected, service, operation, count)
	})

	sc.Then(`^recent logs are non-empty$`, func() error {
		// Assert — start a one-shot capture and wait for any log entry to arrive.
		// The WebSocket endpoint streams all entries since server start, so entries
		// from the StartExecution call in the When step will be delivered here.
		sess := managementSession()
		capture, err := sess.StartLogCapture()
		if err != nil {
			return fmt.Errorf("start log capture: %w", err)
		}
		defer capture.Stop()

		deadline := time.Now().Add(3 * time.Second)
		for time.Now().Before(deadline) {
			if len(capture.Entries()) > 0 {
				return nil
			}
			time.Sleep(50 * time.Millisecond)
		}
		return fmt.Errorf("recent logs are empty after waiting 3s")
	})
}
