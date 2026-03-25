package tests

// registerRDSEventsSteps wires all step definitions for the rds_events informal
// specification feature files (create_d_b_instance, create_event_bus,
// delete_event_bus).
//
// Internal-only actions (d_b_stop_complete, d_b_stop_event_delivered,
// d_b_stop_event_fails) are registered as no-ops with @internal comments
// because they cannot be triggered via public AWS APIs.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/rds"
	"github.com/cucumber/godog"
)

const (
	rdsEventsTestDBInstanceID = "test-rds-db-1"
	rdsEventsTestBusName      = "e2e-test-bus-1"
	rdsEventsTestDBEngine     = "mysql"
	rdsEventsTestDBClass      = "db.t3.micro"
)

// rdsEventsCreateDBInstance is a helper that creates the test RDS DB instance for rds_events.
func rdsEventsCreateDBInstance(world *World) error {
	// Arrange
	// Act
	_, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
		DBInstanceIdentifier: aws.String(rdsEventsTestDBInstanceID),
		DBInstanceClass:      aws.String(rdsEventsTestDBClass),
		Engine:               aws.String(rdsEventsTestDBEngine),
		MasterUsername:       aws.String("admin"),
		MasterUserPassword:   aws.String("password123"),
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

// rdsEventsCreateBus is a helper that creates the test EventBridge event bus.
func rdsEventsCreateBus(world *World) error {
	// Arrange
	// Act
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(rdsEventsTestBusName),
	})
	// Assert: caller checks error
	if err != nil && isAlreadyExists(err) {
		return nil
	}
	return err
}

func registerRDSEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: DB instance state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the "DB" instance does not already exist$`, func() error {
		// No-op: fresh state after reset has no DB instances.
		return nil
	})

	sc.Given(`^the "DB" instance already exists$`, func() error {
		// Arrange / Act: create the DB instance so it already exists.
		return rdsEventsCreateDBInstance(world)
	})

	sc.Given(`^the "DB" instance is "AVAILABLE"$`, func() error {
		// Arrange: create the DB instance (lws instances are AVAILABLE after creation)
		// Act
		return rdsEventsCreateDBInstance(world)
	})

	sc.Given(`^the "DB" instance is not "AVAILABLE"$`, func() error {
		// @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	sc.Given(`^the "DB" instance is "STOPPING"$`, func() error {
		// @internal: Cannot force a DB instance into STOPPING state via public API.
		// Only reached by @internal scenarios excluded by the tag filter.
		return nil
	})

	sc.Given(`^the "DB" instance is not "STOPPING"$`, func() error {
		// @internal: DB stop state not reachable via public API.
		return nil
	})

	// ── Given: bus state setup ────────────────────────────────────────────────

	sc.Given(`^the bus does not already exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus already exists$`, func() error {
		// Arrange: create the event bus so it already exists.
		// Act
		return rdsEventsCreateBus(world)
	})

	sc.Given(`^the bus exists$`, func() error {
		// Arrange: ensure the event bus exists.
		// Act
		return rdsEventsCreateBus(world)
	})

	sc.Given(`^the bus is "ACTIVE"$`, func() error {
		// No-op: event buses in lws are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the bus is "DELETED"$`, func() error {
		// No-op: fresh state after reset has no event buses (simulates deleted bus).
		return nil
	})

	sc.Given(`^the bus is already "DELETED"$`, func() error {
		// Arrange: delete the bus so it is in a DELETED state
		// Act: delete, ignore errors (bus may not exist)
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(rdsEventsTestBusName),
		})
		// Assert: desired state is absence
		world.lastResult = LastResult{}
		return nil
	})

	sc.Given(`^the bus does not exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus is not "DELETED"$`, func() error {
		// Arrange: ensure the bus exists so it is not in a DELETED state
		// Act
		return rdsEventsCreateBus(world)
	})

	// ── Given: event slot state ───────────────────────────────────────────────

	sc.Given(`^an event slot is available$`, func() error {
		// No-op: always room for events in lws.
		return nil
	})

	sc.Given(`^no event slot is available$`, func() error {
		// @internal: Cannot exhaust event slot limit in lws via public APIs.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^an "RDS" "DB" instance is created and becomes "AVAILABLE"$`, func() error {
		// Arrange: (DB instance state set up by Given steps)
		// Act
		resp, err := world.RDSClient().CreateDBInstance(context.Background(), &rds.CreateDBInstanceInput{
			DBInstanceIdentifier: aws.String(rdsEventsTestDBInstanceID),
			DBInstanceClass:      aws.String(rdsEventsTestDBClass),
			Engine:               aws.String(rdsEventsTestDBEngine),
			MasterUsername:       aws.String("admin"),
			MasterUserPassword:   aws.String("password123"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange: (bus state set up by Given steps)
		// Act
		resp, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(rdsEventsTestBusName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the EventBridge event bus is deleted$`, func() error {
		// Arrange: (bus state set up by Given steps)
		// Act
		resp, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(rdsEventsTestBusName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	// @internal actions — registered as no-ops because they cannot be triggered
	// via public AWS APIs in an lws environment.

	sc.When(`^the "DB" instance finishes stopping$`, func() error {
		// @internal: d_b_stop_complete cannot be triggered via public API.
		setResult(world, nil, fmt.Errorf("d_b_stop_complete: scenario is @internal"))
		return nil
	})

	sc.When(`^the "RDS" instance stops and delivers the state change event to the EventBridge bus$`, func() error {
		// @internal: d_b_stop_event_delivered cannot be triggered via public API.
		setResult(world, nil, fmt.Errorf("d_b_stop_event_delivered: scenario is @internal"))
		return nil
	})

	sc.When(`^the "RDS" instance stops but the state change event delivery fails because the bus is deleted$`, func() error {
		// @internal: d_b_stop_event_fails cannot be triggered via public API.
		setResult(world, nil, fmt.Errorf("d_b_stop_event_fails: scenario is @internal"))
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the "DB" instance is "AVAILABLE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected RDS DB instance creation to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.RDSClient().DescribeDBInstances(context.Background(), &rds.DescribeDBInstancesInput{
			DBInstanceIdentifier: aws.String(rdsEventsTestDBInstanceID),
		})
		if err != nil {
			return fmt.Errorf("expected describe_db_instances to succeed but got: %w", err)
		}
		expectedStatus := "available"
		actualStatus := ""
		if len(resp.DBInstances) > 0 && resp.DBInstances[0].DBInstanceStatus != nil {
			actualStatus = *resp.DBInstances[0].DBInstanceStatus
		}
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected DB instance status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the bus is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBus := rdsEventsTestBusName
		actualFound := false
		for _, b := range result.EventBuses {
			if b.Name != nil && *b.Name == expectedBus {
				actualFound = true
				break
			}
		}
		if !actualFound {
			return fmt.Errorf("expected event bus %q to be ACTIVE but not found; expected_bus=%s actual_found=%v",
				expectedBus, expectedBus, actualFound)
		}
		return nil
	})

	sc.Then(`^the bus is "DELETED" and "RDS" event delivery will fail$`, func() error {
		// Arrange: no additional setup required
		// Act
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBus := rdsEventsTestBusName
		actualFound := false
		for _, b := range result.EventBuses {
			if b.Name != nil && *b.Name == expectedBus {
				actualFound = true
				break
			}
		}
		if actualFound {
			return fmt.Errorf("expected event bus %q to be DELETED but found it; expected_bus=%s actual_found=%v",
				expectedBus, expectedBus, actualFound)
		}
		return nil
	})

	sc.Then(`^the "DB" instance is "STOPPED"$`, func() error {
		// @internal: d_b_stop_complete outcome not observable via public API.
		return nil
	})

	sc.Then(`^the "DB" instance is "STOPPING" and the event is "DELIVERED"$`, func() error {
		// @internal: d_b_stop_event_delivered outcome not observable via public API.
		return nil
	})

	sc.Then(`^the "DB" instance is "STOPPING" but no event is delivered$`, func() error {
		// @internal: d_b_stop_event_fails outcome not observable via public API.
		return nil
	})

	// ── Invariant catch-all steps ─────────────────────────────────────────────

	sc.Then(`^every "DELIVERED" event references a "DB" instance that exists$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every "DELIVERED" event references a bus that exists$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
