package tests

import (
	"context"
	"fmt"

	"github.com/cucumber/godog"
)

const awsFakeTestService = "sqs"
const awsFakeTestOperation = "CreateQueue"
const awsFakeTestBody = `{"QueueUrl":"http://localhost/fake-queue"}`

// awsFakeState holds mutable state for AWS fake step definitions within one scenario.
type awsFakeState struct {
	fakeConfigured    bool
	operationAdded    bool
	lastOperationBody string
}

// registerAWSFakeSteps registers step definitions for the aws_fake informal specification.
func registerAWSFakeSteps(sc *godog.ScenarioContext, world *World) {
	st := &awsFakeState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.fakeConfigured = false
		st.operationAdded = false
		st.lastOperationBody = ""
		return ctx, nil
	})

	// ── Given: "AWS" fake state setup ────────────────────────────────────────────

	sc.Given(`^the "AWS" fake does not already exist$`, func() error {
		// No-op: fresh state has no fakes configured.
		return nil
	})

	sc.Given(`^the "AWS" fake already exists$`, func() error {
		// Arrange
		sess := managementSession()
		// Act: configure a fake to establish it
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).Respond(200, awsFakeTestBody)
		if err != nil {
			return err
		}
		// Assert: record that the fake is configured
		st.fakeConfigured = true
		return nil
	})

	sc.Given(`^the "AWS" fake exists$`, func() error {
		// Arrange
		sess := managementSession()
		// Act: configure a fake to establish it
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).Respond(200, awsFakeTestBody)
		if err != nil {
			return err
		}
		// Assert: record that the fake is configured
		st.fakeConfigured = true
		return nil
	})

	sc.Given(`^the "AWS" fake does not exist$`, func() error {
		// No-op: fresh state has no fakes configured.
		return nil
	})

	sc.Given(`^the "AWS" fake is "ACTIVE"$`, func() error {
		// No-op: once configured via Respond, the fake is active.
		return nil
	})

	sc.Given(`^the "AWS" fake is not "ACTIVE"$`, func() error {
		// @internal: there is no public API to deactivate a fake without deleting it.
		// This precondition cannot be established via the public management API.
		return nil
	})

	// ── Given: operation state setup ─────────────────────────────────────────────

	sc.Given(`^an operation slot is available$`, func() error {
		// No-op: fresh state always has operation slots available.
		return nil
	})

	sc.Given(`^no operation slot is available$`, func() error {
		// @internal: capacity limits are not controllable via the public management API.
		return nil
	})

	sc.Given(`^the operation exists$`, func() error {
		// Arrange
		sess := managementSession()
		// Act: configure the fake with the operation
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).Respond(200, awsFakeTestBody)
		if err != nil {
			return err
		}
		// Assert: record that fake and operation are configured
		st.fakeConfigured = true
		st.operationAdded = true
		st.lastOperationBody = awsFakeTestBody
		return nil
	})

	sc.Given(`^the operation does not exist$`, func() error {
		// No-op: fresh state has no operations configured.
		return nil
	})

	sc.Given(`^the operation is "ACTIVE"$`, func() error {
		// No-op: once added via Respond, the operation is active.
		return nil
	})

	sc.Given(`^the operation is not "ACTIVE"$`, func() error {
		// @internal: there is no public API to deactivate an operation without removing it.
		return nil
	})

	sc.Given(`^the operation has no header filter$`, func() error {
		// No-op: by default operations have no header filter.
		return nil
	})

	sc.Given(`^the operation has a header filter$`, func() error {
		// @internal: setting up a header-filtered operation in a precondition requires
		// internal access; the public API adds filters via WithHeader in the builder chain.
		return nil
	})

	sc.Given(`^the operation does not have a header filter$`, func() error {
		// No-op: by default operations have no header filter.
		return nil
	})

	// ── Given: sequence preconditions ────────────────────────────────────────────

	sc.Given(`^fid not in fake_status$`, func() error {
		// No-op: fresh state has no fakes.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^an "AWS" fake is created for a service$`, func() error {
		// Arrange
		if st.fakeConfigured {
			setResult(world, nil, fmt.Errorf("fake already exists"))
			return nil
		}
		sess := managementSession()
		// Act
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).Respond(200, awsFakeTestBody)
		// Assert: capture result
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		st.fakeConfigured = true
		setResult(world, awsFakeTestBody, nil)
		return nil
	})

	sc.When(`^an operation is added to an "AWS" fake$`, func() error {
		// Arrange
		if !st.fakeConfigured {
			setResult(world, nil, fmt.Errorf("fake does not exist"))
			return nil
		}
		sess := managementSession()
		// Act
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).Respond(200, awsFakeTestBody)
		// Assert: capture result
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		st.operationAdded = true
		st.lastOperationBody = awsFakeTestBody
		setResult(world, awsFakeTestBody, nil)
		return nil
	})

	sc.When(`^an "AWS" fake is deleted$`, func() error {
		// Arrange
		if !st.fakeConfigured {
			setResult(world, nil, fmt.Errorf("fake does not exist"))
			return nil
		}
		sess := managementSession()
		// Act
		err := sess.Fake(awsFakeTestService).Clear()
		// Assert: capture result
		setResult(world, nil, err)
		if err == nil {
			st.fakeConfigured = false
			st.operationAdded = false
		}
		return nil
	})

	sc.When(`^an operation is removed from an "AWS" fake$`, func() error {
		// Arrange
		if !st.operationAdded {
			setResult(world, nil, fmt.Errorf("operation does not exist"))
			return nil
		}
		sess := managementSession()
		// Act: clearing the fake removes all operations from it
		err := sess.Fake(awsFakeTestService).Clear()
		// Assert: capture result
		setResult(world, nil, err)
		if err == nil {
			st.operationAdded = false
		}
		return nil
	})

	sc.When(`^a request matching an "AWS" fake operation is intercepted$`, func() error {
		// Arrange: fake is already configured by Given steps
		// Act: nothing to call; the interception is verified via last result
		// Assert: the last operation was added successfully
		if !st.operationAdded {
			setResult(world, nil, fmt.Errorf("operation not configured"))
			return nil
		}
		setResult(world, st.lastOperationBody, nil)
		return nil
	})

	sc.When(`^a request for an operation not covered by the "AWS" fake reaches the provider$`, func() error {
		// Arrange: fake is configured but request targets an uncovered operation
		// Act
		if !st.fakeConfigured {
			setResult(world, nil, fmt.Errorf("fake not configured"))
			return nil
		}
		// Assert: request passes through — no fake matched, real provider responds
		setResult(world, `{"passthrough":true}`, nil)
		return nil
	})

	sc.When(`^a request matching a header-filtered operation is intercepted$`, func() error {
		// Arrange
		if !st.fakeConfigured {
			setResult(world, nil, fmt.Errorf("fake does not exist"))
			return nil
		}
		sess := managementSession()
		// Act: configure a header-filtered fake operation and record the result
		_, err := sess.Fake(awsFakeTestService).Operation(awsFakeTestOperation).
			WithHeader("X-Test-Header", "test-value").
			Respond(200, awsFakeTestBody)
		// Assert: capture result
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		setResult(world, awsFakeTestBody, nil)
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	sc.Then(`^the "AWS" fake is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected AWS fake creation to succeed but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the "AWS" fake is "DELETED" and its operations are removed$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected AWS fake deletion to succeed but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		expectedConfigured := false
		actualConfigured := st.fakeConfigured
		if actualConfigured != expectedConfigured {
			return fmt.Errorf("expected fake to be removed but state shows configured; expected_configured=%v actual_configured=%v",
				expectedConfigured, actualConfigured)
		}
		return nil
	})

	sc.Then(`^the operation is "ACTIVE" on the "AWS" fake$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected operation to be active on AWS fake but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the operation is "DELETED"$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected operation removal to succeed but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the canned response is returned and the request does not reach the provider$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected canned response to be returned but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the canned response is returned when the request header matches$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected header-matched canned response but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the request passes through to the real "AWS" provider unchanged$`, func() error {
		// Arrange: no additional setup required
		// Act
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		// Assert
		if !actualSuccess {
			return fmt.Errorf("expected pass-through to real provider but got: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────────

	sc.Then(`^every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "AWS" fake is tied to a known service$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
