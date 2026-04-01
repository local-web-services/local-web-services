## ADDED Requirements

### Requirement: Cluster Operational State Handlers

The cluster-DB services (Neptune, RDS, DocumentDB) SHALL implement `stop_db_cluster`, `start_db_cluster`, `restore_db_cluster_from_snapshot`, `reboot_db_instance`, and `failover_db_cluster` operation handlers that transition the appropriate resource into an intermediate operational state via `ResourceStateTracker`. Each operation SHALL place the resource in the correct intermediate state (STOPPING, STARTING, RESTORING, REBOOTING, FAILING_OVER) and schedule a transition to the terminal state (STOPPED, AVAILABLE) after `modify_dwell_ms`. The tracker SHALL be registered in the `TrackerRegistry` as `(service, resource_type)` so that `inject_state` can trigger state completions externally.

#### Scenario: Neptune cluster stop transitions through STOPPING

- **GIVEN** a Neptune cluster is AVAILABLE
- **WHEN** `stop_db_cluster` is called with `create_dwell_ms` > 0
- **THEN** `describe_db_clusters` returns status "stopping" until the dwell elapses or inject_state transitions it to "stopped"

#### Scenario: Neptune cluster start transitions through STARTING

- **GIVEN** a Neptune cluster is STOPPED
- **WHEN** `start_db_cluster` is called
- **THEN** `describe_db_clusters` returns status "starting" until it transitions to "available"

#### Scenario: Neptune cluster start completion via inject_state

- **GIVEN** a Neptune cluster is in STARTING state
- **WHEN** `inject_state("neptune", "cluster", cluster-id, "available")` is called
- **THEN** `describe_db_clusters` immediately returns status "available"

#### Scenario: Cluster restore transitions through RESTORING

- **GIVEN** a cluster snapshot exists
- **WHEN** `restore_db_cluster_from_snapshot` is called
- **THEN** the restored cluster begins in "restoring" state and transitions to "available"

#### Scenario: DB instance reboot transitions through REBOOTING

- **GIVEN** an RDS DB instance is AVAILABLE
- **WHEN** `reboot_db_instance` is called
- **THEN** `describe_db_instances` returns status "rebooting" until the instance returns to "available"

### Requirement: ElastiCache and MemoryDB Operational State Handlers

The ElastiCache and MemoryDB providers SHALL implement cluster modification, snapshot create/delete, user/ACL lifecycle, and ACL update operations that transition resources through intermediate states (MODIFYING, SNAPSHOTTING, DELETING, UPDATING) via `ResourceStateTracker`. Each tracker SHALL be registered in the `TrackerRegistry` as `(service, resource_type)` so `inject_state` can trigger completions.

#### Scenario: MemoryDB cluster deletion completes via inject_state

- **GIVEN** a MemoryDB cluster is in DELETING state
- **WHEN** `inject_state("memorydb", "cluster", cluster-name, "deleted")` is called
- **THEN** `describe_clusters` returns NotFound for that cluster

#### Scenario: MemoryDB snapshot creation completes via inject_state

- **GIVEN** a MemoryDB snapshot is in CREATING state
- **WHEN** `inject_state("memorydb", "snapshot", snapshot-name, "available")` is called
- **THEN** `describe_snapshots` returns status "available"

#### Scenario: ElastiCache cluster modification completes via inject_state

- **GIVEN** an ElastiCache cluster is in MODIFYING state
- **WHEN** `inject_state("elasticache", "cluster", cluster-id, "available")` is called
- **THEN** `describe_cache_clusters` returns status "available"

### Requirement: OpenSearch and Elasticsearch Operational State Handlers

The OpenSearch and Elasticsearch providers SHALL implement domain modification and upgrade operations that transition domains through intermediate states (PROCESSING, UPGRADING) via `ResourceStateTracker`. Each tracker SHALL be registered in the `TrackerRegistry` as `(service, "domain")` so `inject_state` can trigger completions.

#### Scenario: OpenSearch domain processing completes via inject_state

- **GIVEN** an OpenSearch domain is in PROCESSING state (e.g. after a modify)
- **WHEN** `inject_state("opensearch", "domain", domain-name, "active")` is called
- **THEN** `describe_domain` returns status "Active"

#### Scenario: Elasticsearch shard reallocation simulated via inject_state

- **GIVEN** an Elasticsearch domain is in ACTIVE state
- **WHEN** `inject_state("es", "domain", domain-name, "processing")` is called
- **THEN** `describe_elasticsearch_domain` returns processing=true
