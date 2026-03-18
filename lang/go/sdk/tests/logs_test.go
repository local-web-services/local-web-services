package tests

import (
	"github.com/cucumber/godog"
)

// registerLogsSteps registers log capture step definitions.
// All log capture scenarios are marked pending because the Go core in-process
// server does not implement WebSocket log streaming (/_ldk/ws/logs) and
// providers do not call AppendLog, so the /_ldk/logs endpoint always returns
// empty results. Log capture requires the ldk dev process.
func registerLogsSteps(sc *godog.ScenarioContext, world *World) {
	sc.When(`^I start log capture and call "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.Then(`^the log capture will contain a "([^"]*)" "([^"]*)" entry$`, func(service, operation string) error {
		return godog.ErrPending
	})

	sc.Then(`^no errors will appear in the log capture$`, func() error {
		return godog.ErrPending
	})

	sc.When(`^I start log capture and call both "([^"]*)" "([^"]*)" and "([^"]*)" "([^"]*)"$`,
		func(svc1, op1, svc2, op2 string) error {
			_ = world
			return godog.ErrPending
		})

	sc.Then(`^filtering by service "([^"]*)" returns only ([^ ]+) entries$`, func(filterService, _ string) error {
		return godog.ErrPending
	})

	sc.Then(`^filtering by operation "([^"]*)" returns at least one entry$`, func(operation string) error {
		return godog.ErrPending
	})

	sc.When(`^I start log capture and call "([^"]*)" "([^"]*)" twice$`, func(service, operation string) error {
		_ = world
		return godog.ErrPending
	})

	sc.Then(`^the log capture will contain exactly (\d+) "([^"]*)" "([^"]*)" entries$`, func(expected int, service, operation string) error {
		return godog.ErrPending
	})

	sc.Then(`^recent logs are non-empty$`, func() error {
		return godog.ErrPending
	})
}

// fakeCaptureAdapter is a placeholder (no longer used but kept to avoid breaking world_test.go)
type fakeCaptureAdapter struct{}
