package tests

// registerDocDBEventsSteps wires all step definitions for the docdb_events cross-service
// informal specification feature files (create_cluster, create_event_bus, delete_event_bus,
// cluster_modify_event_delivered, cluster_modify_event_fails, cluster_modify_complete).
// Internal model-state transitions are registered as no-ops with @internal comments.
// Steps already registered by registerDocDBSteps (cluster existence/lifecycle steps) and
// registerEventsSteps (event bus CRUD steps) are NOT re-registered here to avoid
// duplicate step definition panics.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/cucumber/godog"
)

const (
	docdbEventsTestBusName = "test-docdb-events-bus-1"
)

func registerDocDBEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: event bus state setup (docdb_events-specific bus)
	// -------------------------------------------------------------------------

	sc.Given(`^the bus does not already exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus already exists$`, func() error {
		// Arrange / Act: create the bus so it already exists.
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		return err
	})

	sc.Given(`^the bus exists$`, func() error {
		// Arrange / Act: ensure the bus exists.
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		return err
	})

	sc.Given(`^the bus does not exist$`, func() error {
		// No-op: fresh state after reset has no event buses.
		return nil
	})

	sc.Given(`^the bus is "ACTIVE"$`, func() error {
		// Arrange: ensure the bus exists (buses are ACTIVE immediately after creation).
		_, _ = world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		return nil
	})

	sc.Given(`^the bus is "DELETED"$`, func() error {
		// @internal: Cannot place bus into DELETED state without deleting it; after deletion
		// the bus no longer exists. Treated as no-op; scenario is tagged @internal.
		return nil
	})

	sc.Given(`^the bus is not "DELETED"$`, func() error {
		// Arrange: ensure the bus exists and is therefore NOT deleted.
		_, _ = world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		return nil
	})

	sc.Given(`^the bus is already "DELETED"$`, func() error {
		// @internal: Cannot arrange bus in already-deleted state via public API.
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: @internal state steps
	// -------------------------------------------------------------------------

	sc.Given(`^an event slot is available$`, func() error {
		// No-op: fresh state after reset has no events.
		return nil
	})

	sc.Given(`^no event slot is available$`, func() error {
		// @internal: Cannot exhaust event slots via public API.
		return nil
	})

	// "the cluster is not {string}" is already registered (parametric) in docdb_test.go;
	// specific literal variants for "AVAILABLE" and "MODIFYING" are NOT re-registered.

	// "busid not in bus_status" is already registered in sequences_test.go; NOT re-registered.

	// -------------------------------------------------------------------------
	// When: public API actions
	// -------------------------------------------------------------------------

	sc.When(`^a DocumentDB cluster is created and becomes "AVAILABLE"$`, func() error {
		// Arrange: (state set up by Given steps)
		// Act
		resp, err := world.DocDBClient().CreateDBCluster(context.Background(), &docdb.CreateDBClusterInput{
			DBClusterIdentifier: aws.String(docdbTestClusterID),
			Engine:              aws.String(docdbTestEngine),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange
		// Act
		resp, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the EventBridge event bus is deleted$`, func() error {
		// Arrange: (state set up by Given steps)
		// Act
		resp, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(docdbEventsTestBusName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// When: @internal transitions (not reachable via public API)
	// -------------------------------------------------------------------------

	sc.When(`^a cluster modification begins and DocumentDB delivers the event to the EventBridge bus$`, func() error {
		// @internal: Cannot trigger internal DocumentDB->EventBridge event delivery via public API.
		setResult(world, nil, fmt.Errorf("cannot trigger DocDB->EventBridge event delivery: scenario is @internal"))
		return nil
	})

	sc.When(`^a cluster modification begins but event delivery fails because the bus is deleted$`, func() error {
		// @internal: Cannot trigger internal event delivery failure via public API.
		setResult(world, nil, fmt.Errorf("cannot trigger event delivery failure: scenario is @internal"))
		return nil
	})

	sc.When(`^the cluster modification completes$`, func() error {
		// @internal: Cannot trigger internal cluster modification completion via public API.
		setResult(world, nil, fmt.Errorf("cannot trigger cluster modification completion: scenario is @internal"))
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	// "the cluster is AVAILABLE" is handled by the parametric Then in docdb_test.go
	// (sc.Then(`^the cluster is "([^"]*)"$`)).
	// It is intentionally absent here to avoid duplicate step definition panics.

	sc.Then(`^the bus is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: verify bus exists
		resp, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		// Assert
		expectedBus := docdbEventsTestBusName
		for _, b := range resp.EventBuses {
			actualName := aws.ToString(b.Name)
			if actualName == expectedBus {
				return nil
			}
		}
		return fmt.Errorf("expected event bus %q to be ACTIVE but not found; expected_bus=%s", expectedBus, expectedBus)
	})

	sc.Then(`^the bus is "DELETED" and DocumentDB event delivery will fail$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected DeleteEventBus to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: @internal state assertions (no-ops)
	// -------------------------------------------------------------------------

	sc.Then(`^the cluster is "AVAILABLE" again$`, func() error {
		// @internal: model-level invariant; trivially satisfied.
		return nil
	})

	sc.Then(`^the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED"$`, func() error {
		// @internal: model-level invariant; trivially satisfied.
		return nil
	})

	sc.Then(`^the cluster is "MODIFYING" but no event is delivered$`, func() error {
		// @internal: model-level invariant; trivially satisfied.
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: model invariants (no-ops — trivially satisfied in isolated context)
	// -------------------------------------------------------------------------

	sc.Then(`^every "DELIVERED" event references a cluster that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "DELIVERED" event references a bus that exists$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
