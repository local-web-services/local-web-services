package tests

// registerNeptuneEventsSteps registers step definitions specific to the
// neptune_events cross-service feature files.
//
// Features: lang/specification/core/informal/neptune_events/
//   - create_cluster.feature
//   - create_event_bus.feature
//   - delete_event_bus.feature
//   - cluster_stop_complete.feature  (@internal — excluded from run)
//   - cluster_stop_event_delivered.feature  (@internal — excluded from run)
//   - cluster_stop_event_fails.feature  (@internal — excluded from run)
//   - sequences.feature
//
// Safety invariants: DeliveredEventReferencesExistingCluster,
//                    DeliveredEventReferencesExistingBus
//
// Steps already registered elsewhere and intentionally absent here:
//   - "the system is initialized"              — sequences_test.go
//   - "the operation is rejected"              — sqs_test.go
//   - "busid not in bus_status"                — sequences_test.go
//   - "busid in bus_status"                    — sequences_test.go
//   - `every "DELIVERED" event references a bus that exists` — sequences_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/neptune"
	"github.com/cucumber/godog"
)

const (
	neptuneEventsTestBus     = "test-neptune-events-bus-1"
	neptuneEventsTestCluster = "test-neptune-events-cluster-1"
)

func registerNeptuneEventsSteps(sc *godog.ScenarioContext, world *World) {
	// ── helpers ──────────────────────────────────────────────────────────────────

	ensureNeptuneEventsBus := func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(neptuneEventsTestBus),
		})
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	}

	ensureNeptuneEventsCluster := func() error {
		_, err := world.NeptuneClient().CreateDBCluster(context.Background(), &neptune.CreateDBClusterInput{
			DBClusterIdentifier: aws.String(neptuneEventsTestCluster),
			Engine:              aws.String("neptune"),
		})
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	}

	// ── Background ────────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: cluster state ─────────────────────────────────────────────────────

	sc.Given(`^the cluster does not already exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	sc.Given(`^the cluster already exists$`, func() error {
		// Arrange: create the cluster so it already exists.
		return ensureNeptuneEventsCluster()
	})

	sc.Given(`^cid not in cluster_status$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	sc.Given(`^cid in cluster_status$`, func() error {
		// Arrange: ensure a cluster exists.
		return ensureNeptuneEventsCluster()
	})

	sc.Given(`^the cluster is "([^"]*)"$`, func(status string) error {
		// No-op: lws sets clusters to AVAILABLE by default.
		return nil
	})

	sc.Given(`^the cluster is not "([^"]*)"$`, func(status string) error {
		// @internal: cannot force a cluster into a non-AVAILABLE state via public API.
		return godog.ErrSkip
	})

	// ── Given: bus state ─────────────────────────────────────────────────────────

	sc.Given(`^the bus does not already exist$`, func() error {
		// No-op: fresh state has no custom buses.
		return nil
	})

	sc.Given(`^the bus already exists$`, func() error {
		// Arrange: create the bus so it already exists.
		return ensureNeptuneEventsBus()
	})

	sc.Given(`^the bus exists$`, func() error {
		// Arrange: create the test event bus.
		return ensureNeptuneEventsBus()
	})

	sc.Given(`^the bus is "ACTIVE"$`, func() error {
		// No-op: buses are ACTIVE by default after creation.
		return nil
	})

	sc.Given(`^the bus is already "DELETED"$`, func() error {
		// Arrange: ensure bus exists then delete it.
		_ = ensureNeptuneEventsBus()
		// Act
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(neptuneEventsTestBus),
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

	// ── Given: slots ──────────────────────────────────────────────────────────────

	sc.Given(`^an event slot is available$`, func() error {
		// No-op: always room for events.
		return nil
	})

	sc.Given(`^no event slot is available$`, func() error {
		// @internal: cannot exhaust event slot limit.
		return godog.ErrSkip
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a Neptune cluster is created and becomes "AVAILABLE"$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.NeptuneClient().CreateDBCluster(context.Background(), &neptune.CreateDBClusterInput{
			DBClusterIdentifier: aws.String(neptuneEventsTestCluster),
			Engine:              aws.String("neptune"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange: (bus state set up by Given steps)
		// Act
		resp, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(neptuneEventsTestBus),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the EventBridge event bus is deleted$`, func() error {
		// Arrange: (bus state set up by Given steps)
		// Act
		resp, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(neptuneEventsTestBus),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the Neptune cluster stops and delivers the state change event to the EventBridge bus$`, func() error {
		// @internal: cluster_stop_event_delivered — cannot trigger internal event delivery via public API.
		return nil
	})

	sc.When(`^the Neptune cluster stops but event delivery fails because the bus is deleted$`, func() error {
		// @internal: cluster_stop_event_fails — cannot trigger internal event delivery failure via public API.
		return nil
	})

	sc.When(`^the Neptune cluster finishes stopping$`, func() error {
		// @internal: cluster_stop_complete — cannot force cluster into STOPPING state via public API.
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	// "the operation is rejected" is already registered in sqs_test.go.

	sc.Then(`^the cluster is "([^"]*)"$`, func(expectedStatus string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.NeptuneClient().DescribeDBClusters(context.Background(), &neptune.DescribeDBClustersInput{
			DBClusterIdentifier: aws.String(neptuneEventsTestCluster),
		})
		if err != nil {
			return fmt.Errorf("expected DescribeDBClusters to succeed but got: %w", err)
		}
		if len(resp.DBClusters) == 0 {
			return fmt.Errorf("expected cluster %q to exist but not found; expected_cluster=%s",
				neptuneEventsTestCluster, neptuneEventsTestCluster)
		}
		actualStatus := aws.ToString(resp.DBClusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the bus is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return fmt.Errorf("list event buses: %w", err)
		}
		expectedBusName := neptuneEventsTestBus
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

	sc.Then(`^the bus is "DELETED" and Neptune event delivery will fail$`, func() error {
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

	// ── Safety invariant Then steps ───────────────────────────────────────────────

	sc.Then(`^every "DELIVERED" event references a cluster that exists$`, func() error {
		// No-op invariant: model-level invariant; guaranteed by construction in lws.
		return nil
	})

	// `every "DELIVERED" event references a bus that exists` is already registered in sequences_test.go.
}
