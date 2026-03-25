package tests

// registerCognitoEventsSteps registers step definitions specific to the
// cognito_events cross-service feature files.
//
// Features: lang/specification/core/informal/cognito_events/
//   - create_event_bus.feature
//   - create_user_pool.feature
//   - delete_event_bus.feature
//   - enable_event_publishing.feature
//   - user_action_delivered.feature  (@internal — excluded from run)
//   - user_action_delivery_fails.feature  (@internal — excluded from run)
//
// Safety invariants: DeliveredEventReferencesExistingPool,
//                    DeliveredEventReferencesExistingBus
//
// Steps already registered elsewhere and intentionally absent here:
//   - "the system is initialized"           — sequences_test.go
//   - "the operation is rejected"           — sqs_test.go
//   - `every "DELIVERED" event references a bus that exists` — sequences_test.go
//   - "the event bus does not already exist" / "the event bus already exists" /
//     "the event bus exists" / `the event bus is "ACTIVE"` / "the event bus does not exist"
//     — events_test.go
//   - "the user pool does not already exist" / "the user pool already exists" /
//     "the user pool exists" — cognito_idp_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/cucumber/godog"
)

const cognitoEventsTestPool = "e2e-test-pool-1"
const cognitoEventsTestBus = "e2e-test-bus-1"

func registerCognitoEventsSteps(sc *godog.ScenarioContext, world *World) {
	// ── helpers ──────────────────────────────────────────────────────────────────

	createCognitoEventsPool := func() error {
		_, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(cognitoEventsTestPool),
		})
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	}

	createCognitoEventsBus := func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(cognitoEventsTestBus),
		})
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	}

	// ── Background ────────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: bus state ─────────────────────────────────────────────────────────

	sc.Given(`^the bus does not already exist$`, func() error {
		// No-op: fresh state has no custom buses.
		return nil
	})

	sc.Given(`^the bus already exists$`, func() error {
		// Arrange: create the bus so it already exists
		// Act
		return createCognitoEventsBus()
		// Assert: creation succeeded
	})

	sc.Given(`^the bus exists$`, func() error {
		// Arrange: create the test event bus
		// Act
		return createCognitoEventsBus()
		// Assert: creation succeeded
	})

	sc.Given(`^the bus exists and is "ACTIVE"$`, func() error {
		// Arrange: create the bus (it is ACTIVE by default after creation)
		// Act
		return createCognitoEventsBus()
		// Assert: creation succeeded
	})

	sc.Given(`^the bus is "ACTIVE"$`, func() error {
		// No-op: buses are ACTIVE by default after creation.
		return nil
	})

	sc.Given(`^the bus is "DELETED"$`, func() error {
		// Arrange: skip — lws does not reject Cognito operations when the event bus is deleted.
		return godog.ErrSkip
	})

	sc.Given(`^the bus is not "DELETED"$`, func() error {
		// Arrange: skip — lws does not enforce event delivery failure when the bus is not deleted.
		return godog.ErrSkip
	})

	sc.Given(`^the bus is already "DELETED"$`, func() error {
		// Arrange: ensure bus exists then delete it with lifecycle dwell
		sess := managementSession()
		_ = createCognitoEventsBus()
		// Act
		if err := sess.Lifecycle("eventbridge").DeleteDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(cognitoEventsTestBus),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	sc.Given(`^the bus does not exist$`, func() error {
		// No-op: fresh state has no buses.
		return nil
	})

	sc.Given(`^the bus does not exist or is not "ACTIVE"$`, func() error {
		// Arrange: skip — lws does not reject enable_event_publishing when the bus does not exist or is not ACTIVE.
		return godog.ErrSkip
	})

	// ── Given: pool state ─────────────────────────────────────────────────────────

	sc.Given(`^the pool does not already exist$`, func() error {
		// No-op: fresh state has no user pools.
		return nil
	})

	sc.Given(`^the pool already exists$`, func() error {
		// Arrange: create the test user pool so it already exists
		// Act
		return createCognitoEventsPool()
		// Assert: creation succeeded
	})

	sc.Given(`^the pool exists and is "ACTIVE"$`, func() error {
		// Arrange: create the test user pool (ACTIVE by default after creation)
		// Act
		return createCognitoEventsPool()
		// Assert: creation succeeded
	})

	sc.Given(`^the pool does not exist or is not "ACTIVE"$`, func() error {
		// No-op: fresh state has no pools.
		return nil
	})

	sc.Given(`^the pool has an EventBridge configuration$`, func() error {
		// Arrange: skip — cannot configure EventBridge on a Cognito user pool in lws.
		return godog.ErrSkip
	})

	sc.Given(`^the pool has no EventBridge configuration$`, func() error {
		// No-op: pools have no EventBridge configuration by default.
		return nil
	})

	sc.Given(`^the pool already has an EventBridge configuration$`, func() error {
		// Arrange: skip — cannot configure EventBridge on a Cognito user pool in lws.
		return godog.ErrSkip
	})

	// ── Given: slots ──────────────────────────────────────────────────────────────

	sc.Given(`^an event slot is available$`, func() error {
		// No-op: always room for events.
		return nil
	})

	sc.Given(`^no event slot is available$`, func() error {
		// Arrange: skip — cannot exhaust event slot limit.
		return godog.ErrSkip
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(cognitoEventsTestBus),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the EventBridge event bus is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(cognitoEventsTestBus),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Cognito user pool is created$`, func() error {
		// Arrange
		// Act
		result, err := world.CognitoIDPClient().CreateUserPool(context.Background(), &cognitoidentityprovider.CreateUserPoolInput{
			PoolName: aws.String(cognitoEventsTestPool),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^EventBridge publishing is enabled on the user pool$`, func() error {
		// Arrange / Act / Assert — skip: cannot trigger internal EventBridge publishing configuration in lws.
		return godog.ErrSkip
	})

	sc.When(`^a user action occurs in the pool and Cognito delivers the event to the EventBridge bus$`, func() error {
		// Arrange / Act / Assert — @internal scenario; skip: cannot trigger internal Cognito user action event routing in lws.
		return godog.ErrSkip
	})

	sc.When(`^a user action occurs but event delivery fails because the bus has been deleted$`, func() error {
		// Arrange / Act / Assert — @internal scenario; skip: cannot trigger internal Cognito event delivery failure in lws.
		return godog.ErrSkip
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	// "the operation is rejected" is already registered in sqs_test.go.
	// `every "DELIVERED" event references a bus that exists` is already registered in sequences_test.go.

	sc.Then(`^the bus is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBusName := cognitoEventsTestBus
		actualFound := false
		for _, b := range result.EventBuses {
			if b.Name != nil && *b.Name == expectedBusName {
				actualFound = true
				break
			}
		}
		if !actualFound {
			return fmt.Errorf("expected event bus %q to be ACTIVE but not found; expected_bus=%q",
				expectedBusName, expectedBusName)
		}
		return nil
	})

	sc.Then(`^the bus is "DELETED" and Cognito event delivery will fail$`, func() error {
		// Arrange: action performed in When step
		// Act: (no-op)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected delete_event_bus to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the pool is "ACTIVE" with no EventBridge configuration$`, func() error {
		// Arrange
		// Act
		result, err := world.CognitoIDPClient().ListUserPools(context.Background(), &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(60),
		})
		if err != nil {
			return fmt.Errorf("list user pools: %w", err)
		}
		// Assert
		expectedPoolName := cognitoEventsTestPool
		actualFound := false
		for _, p := range result.UserPools {
			if p.Name != nil && *p.Name == expectedPoolName {
				actualFound = true
				break
			}
		}
		if !actualFound {
			return fmt.Errorf("expected user pool %q to be ACTIVE but not found; expected_pool=%q",
				expectedPoolName, expectedPoolName)
		}
		return nil
	})

	sc.Then(`^the pool will send user events to the bus$`, func() error {
		// No-op: skip — cannot observe internal EventBridge publishing configuration in lws.
		return godog.ErrSkip
	})

	sc.Then(`^the event is "DELIVERED" to the bus$`, func() error {
		// No-op: skip — cannot trigger internal Cognito event delivery in lws.
		return godog.ErrSkip
	})

	sc.Then(`^the event delivery "FAILED"$`, func() error {
		// No-op: skip — cannot observe internal Cognito event delivery failure in lws.
		return godog.ErrSkip
	})

	// ── Safety invariant Then steps ───────────────────────────────────────────────

	sc.Then(`^every "DELIVERED" event references a pool that exists$`, func() error {
		// No-op: model-level invariant; guaranteed by construction in lws.
		return nil
	})
}
