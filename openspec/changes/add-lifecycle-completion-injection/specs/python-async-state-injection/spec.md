## ADDED Requirements

### Requirement: Provider Lifecycle Tracker Registry

The core management layer SHALL maintain a `TrackerRegistry` (`dict[tuple[str, str], ResourceStateTracker]`) keyed by `(service, resource_type)`. Every provider app factory that uses `ResourceStateTracker` SHALL register its tracker instances in this registry at creation time. The `_dispatch_injection` function SHALL look up the registry and call `tracker.set_state` or `tracker.remove` when `inject_state` is called for a registered `(service, resource_type)` pair. When no tracker is registered for a pair, the existing `AsyncStateStore`-only path SHALL remain as the fallback.

#### Scenario: inject_state reaches cluster tracker

- **GIVEN** a Neptune cluster exists and is in CREATING state (dwell timer active)
- **WHEN** `inject_state("neptune", "cluster", cluster-id, "available")` is called
- **THEN** the cluster tracker transitions to ACTIVE, the dwell timer is cancelled, and `describe_db_clusters` returns status "available"

#### Scenario: inject_state removes deleting resource

- **GIVEN** an OpenSearch domain exists and is in DELETING state (dwell timer active)
- **WHEN** `inject_state("opensearch", "domain", domain-name, "deleted")` is called
- **THEN** the domain is removed from the tracker and `describe_domain` returns a NotFound error

#### Scenario: Unknown service falls back to AsyncStateStore

- **GIVEN** no tracker is registered for service "unknown" resource_type "widget"
- **WHEN** `inject_state("unknown", "widget", id, "ACTIVE")` is called
- **THEN** the state is written to `AsyncStateStore` and GET returns "ACTIVE" with no error

### Requirement: Snapshot Lifecycle State Tracking

The `cluster_db_service` factory SHALL create a `_snapshot_tracker` (`ResourceStateTracker`) for each cluster-DB app instance and register it in the `TrackerRegistry` as `(service, "snapshot")`. When a snapshot is created, it SHALL be placed in CREATING state and scheduled to transition to AVAILABLE after `create_dwell_ms`. When `inject_state` is called with state "available", the snapshot SHALL immediately transition to AVAILABLE. When a snapshot is deleted, it SHALL be placed in DELETING state and removed after `delete_dwell_ms`.

#### Scenario: Snapshot finishes creating via inject_state

- **GIVEN** a Neptune cluster snapshot is in CREATING state
- **WHEN** `inject_state("neptune", "snapshot", snapshot-id, "available")` is called
- **THEN** `describe_db_cluster_snapshots` returns status "available" for the snapshot

#### Scenario: Snapshot describe blocked while CREATING

- **GIVEN** a Neptune cluster snapshot is in CREATING state
- **WHEN** `describe_db_cluster_snapshots` is called with the snapshot identifier
- **THEN** the response returns status "creating", not "available"

#### Scenario: Snapshot deletion completes via inject_state

- **GIVEN** a Neptune cluster snapshot is in DELETING state
- **WHEN** `inject_state("neptune", "snapshot", snapshot-id, "deleted")` is called
- **THEN** `describe_db_cluster_snapshots` returns NotFoundFault for that snapshot

## MODIFIED Requirements

### Requirement: Cluster Service Injected Operational States

The lifecycle-tracked services (ElastiCache, Neptune, RDS, DocumentDB, MemoryDB, OpenSearch, Elasticsearch, S3Tables) SHALL support all operational intermediate states (MODIFYING, STOPPING, STOPPED, STARTING, SNAPSHOTTING, RESTORING, REBOOTING, FAILING_OVER) registered in the `TrackerRegistry`. When `inject_state` is called with one of these states, the tracker SHALL be updated immediately, `describe` operations SHALL return the injected state, and write operations that are invalid for that state SHALL be rejected with the appropriate fault (e.g. `InvalidDBClusterStateFault`, `InvalidClusterStateFault`).

#### Scenario: Modifying cluster rejects certain operations

- **GIVEN** a cluster is injected into MODIFYING state via the TrackerRegistry
- **WHEN** a second modify operation is attempted
- **THEN** the operation is rejected with InvalidDBClusterStateFault or equivalent error

#### Scenario: Stopped cluster describe returns STOPPED

- **GIVEN** a Neptune cluster has been injected into STOPPED state
- **WHEN** `describe_db_clusters` is called
- **THEN** the cluster status is returned as "stopped"

#### Scenario: Rebooting instance rejects operations

- **GIVEN** an RDS DB instance is injected into REBOOTING state
- **WHEN** `delete_db_instance` is attempted
- **THEN** the operation is rejected with InvalidDBInstanceState
