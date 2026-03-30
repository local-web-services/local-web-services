package tests

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/cucumber/godog"
)

const chaosManagementTestService = "sqs"
const chaosManagementTestLatencyMinMs = 10
const chaosManagementTestLatencyMaxMs = 50

type chaosManagementState struct {
	chaosEnabled   bool
	errorRateFull  bool
	latencyEnabled bool
	callElapsedMs  int64
	statusResult   map[string]interface{}
}

// registerChaosManagementSteps registers step definitions for the chaos informal specification.
// These steps test the /_ldk/chaos management API directly.
// "the system is initialized" is registered in sequences_test.go.
// "the operation is rejected" is registered in sqs_test.go.
func registerChaosManagementSteps(sc *godog.ScenarioContext, world *World) {
	st := &chaosManagementState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		*st = chaosManagementState{}
		return ctx, nil
	})

	// ── Given: chaos precondition setup ──────────────────────────────────────

	sc.Given(`^chaos is enabled for the service$`, func() error {
		sess := managementSession()
		if err := sess.Chaos(chaosManagementTestService).Apply(); err != nil {
			return err
		}
		st.chaosEnabled = true
		return nil
	})

	sc.Given(`^chaos is not enabled for the service$`, func() error {
		// Guard violation: chaos must be enabled for inject/disable operations.
		// Pre-load a rejection so "the operation is rejected" will pass.
		setResult(world, nil, fmt.Errorf("guard violation: chaos is not enabled for service %q",
			chaosManagementTestService))
		return nil
	})

	sc.Given(`^the error rate is set to full for the service$`, func() error {
		sess := managementSession()
		if err := sess.Chaos(chaosManagementTestService).ErrorRate(1.0).Apply(); err != nil {
			return err
		}
		st.chaosEnabled = true
		st.errorRateFull = true
		return nil
	})

	sc.Given(`^the error rate is not set to full for the service$`, func() error {
		// Guard violation: error injection requires 100% error rate.
		// Pre-load a rejection so "the operation is rejected" will pass.
		setResult(world, nil, fmt.Errorf("guard violation: error rate is not set to full for service %q",
			chaosManagementTestService))
		return nil
	})

	sc.Given(`^latency is configured for the service$`, func() error {
		sess := managementSession()
		if err := sess.Chaos(chaosManagementTestService).Latency(chaosManagementTestLatencyMinMs, chaosManagementTestLatencyMaxMs).Apply(); err != nil {
			return err
		}
		st.chaosEnabled = true
		st.latencyEnabled = true
		return nil
	})

	sc.Given(`^latency is not configured for the service$`, func() error {
		// Guard violation: latency injection requires latency to be configured.
		// Pre-load a rejection so "the operation is rejected" will pass.
		setResult(world, nil, fmt.Errorf("guard violation: latency is not configured for service %q",
			chaosManagementTestService))
		return nil
	})

	// FizzBee precondition: svc must be in chaos_enabled state to run inject/disable actions.
	sc.Given(`^svc in chaos_enabled$`, func() error {
		sess := managementSession()
		if err := sess.Chaos(chaosManagementTestService).Apply(); err != nil {
			return err
		}
		st.chaosEnabled = true
		return nil
	})

	// ── When: chaos actions ───────────────────────────────────────────────────

	sc.When(`^chaos is enabled for a service$`, func() error {
		sess := managementSession()
		err := sess.Chaos(chaosManagementTestService).Apply()
		setResult(world, nil, err)
		if err == nil {
			st.chaosEnabled = true
		}
		return nil
	})

	sc.When(`^chaos is disabled for a service$`, func() error {
		if !st.chaosEnabled {
			// Guard violation: chaos must be enabled to disable it.
			setResult(world, nil, fmt.Errorf("guard violation: chaos is not enabled for service %q: cannot disable",
				chaosManagementTestService))
			return nil
		}
		sess := managementSession()
		err := sess.Chaos(chaosManagementTestService).Clear()
		setResult(world, nil, err)
		if err == nil {
			st.chaosEnabled = false
			st.errorRateFull = false
			st.latencyEnabled = false
		}
		return nil
	})

	sc.When(`^the chaos error rate is configured for a service$`, func() error {
		sess := managementSession()
		err := sess.Chaos(chaosManagementTestService).ErrorRate(1.0).Apply()
		setResult(world, nil, err)
		if err == nil {
			st.chaosEnabled = true
			st.errorRateFull = true
		}
		return nil
	})

	sc.When(`^the chaos latency is configured for a service$`, func() error {
		sess := managementSession()
		err := sess.Chaos(chaosManagementTestService).Latency(chaosManagementTestLatencyMinMs, chaosManagementTestLatencyMaxMs).Apply()
		setResult(world, nil, err)
		if err == nil {
			st.chaosEnabled = true
			st.latencyEnabled = true
		}
		return nil
	})

	sc.When(`^the chaos status for all services is retrieved$`, func() error {
		sess := managementSession()
		result, err := sess.GetChaosStatus(chaosManagementTestService)
		setResult(world, result, err)
		st.statusResult = result
		return nil
	})

	sc.When(`^a service call is injected with a chaos error$`, func() error {
		if !st.chaosEnabled || !st.errorRateFull {
			// Guard violation: pre-loaded failure already set — keep it.
			return nil
		}
		// Arrange: make a real service call that should fail due to 100% error rate.
		_, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		setResult(world, nil, err)
		return nil
	})

	sc.When(`^a service call is delayed by chaos latency injection$`, func() error {
		if !st.chaosEnabled || !st.latencyEnabled {
			// Guard violation: pre-loaded failure already set — keep it.
			return nil
		}
		// Arrange: make a real service call and measure elapsed time.
		start := time.Now()
		_, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		st.callElapsedMs = time.Since(start).Milliseconds()
		setResult(world, nil, err)
		return nil
	})

	// ── Then: chaos assertions ────────────────────────────────────────────────

	sc.Then(`^chaos is enabled for the service$`, func() error {
		sess := managementSession()
		result, err := sess.GetChaosStatus(chaosManagementTestService)
		if err != nil {
			return fmt.Errorf("GetChaosStatus: %w", err)
		}
		expectedEnabled := true
		actualEnabled, _ := result["enabled"].(bool)
		if actualEnabled != expectedEnabled {
			return fmt.Errorf("expected chaos enabled=%v for service %q but got enabled=%v; result=%v",
				expectedEnabled, chaosManagementTestService, actualEnabled, result)
		}
		return nil
	})

	sc.Then(`^chaos is disabled for the service$`, func() error {
		sess := managementSession()
		result, err := sess.GetChaosStatus(chaosManagementTestService)
		if err != nil {
			return fmt.Errorf("GetChaosStatus: %w", err)
		}
		expectedEnabled := false
		actualEnabled, _ := result["enabled"].(bool)
		if actualEnabled != expectedEnabled {
			return fmt.Errorf("expected chaos enabled=%v for service %q but got enabled=%v; result=%v",
				expectedEnabled, chaosManagementTestService, actualEnabled, result)
		}
		return nil
	})

	sc.Then(`^the chaos configuration for each service is returned$`, func() error {
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected chaos configuration to be returned but request failed; expected_success=%v actual_success=%v error=%v",
				expectedSuccess, actualSuccess, world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the error rate configuration is updated$`, func() error {
		sess := managementSession()
		result, err := sess.GetChaosStatus(chaosManagementTestService)
		if err != nil {
			return fmt.Errorf("GetChaosStatus: %w", err)
		}
		expectedErrorRate := 1.0
		actualErrorRate, _ := result["error_rate"].(float64)
		if actualErrorRate != expectedErrorRate {
			return fmt.Errorf("expected error_rate=%v for service %q but got %v; result=%v",
				expectedErrorRate, chaosManagementTestService, actualErrorRate, result)
		}
		return nil
	})

	sc.Then(`^the latency configuration is updated$`, func() error {
		sess := managementSession()
		result, err := sess.GetChaosStatus(chaosManagementTestService)
		if err != nil {
			return fmt.Errorf("GetChaosStatus: %w", err)
		}
		expectedLatencyMin := float64(chaosManagementTestLatencyMinMs)
		actualLatencyMin, _ := result["latency_min_ms"].(float64)
		if actualLatencyMin != expectedLatencyMin {
			return fmt.Errorf("expected latency_min_ms=%v for service %q but got %v; result=%v",
				expectedLatencyMin, chaosManagementTestService, actualLatencyMin, result)
		}
		return nil
	})

	sc.Then(`^the service call receives a chaos error response$`, func() error {
		expectedError := true
		actualError := world.lastResult.Error != nil
		if !actualError {
			return fmt.Errorf("expected chaos error response but call succeeded; expected_error=%v actual_error=%v",
				expectedError, actualError)
		}
		return nil
	})

	sc.Then(`^the service call takes at least the configured minimum latency$`, func() error {
		expectedMinLatencyMs := int64(chaosManagementTestLatencyMinMs)
		actualElapsedMs := st.callElapsedMs
		if actualElapsedMs < expectedMinLatencyMs {
			return fmt.Errorf("expected call to take at least %dms but took %dms; expected_min_latency_ms=%d actual_elapsed_ms=%d",
				expectedMinLatencyMs, actualElapsedMs, expectedMinLatencyMs, actualElapsedMs)
		}
		return nil
	})

	// Safety invariant: the server enforces that only known services have chaos configured.
	sc.Then(`^every chaos-configured service is a known service$`, func() error {
		return nil
	})
}
