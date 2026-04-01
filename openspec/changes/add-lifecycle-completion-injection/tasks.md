## Phase 1: TrackerRegistry — Core Infrastructure

- [x] 1.1 Add `TrackerRegistry = dict[tuple[str, str], ResourceStateTracker]` type alias to `aws_lifecycle.py`
- [x] 1.2 Add `register_tracker(registry, service, resource_type, tracker)` helper to `aws_lifecycle.py` (avoids boilerplate in each factory)
- [x] 1.3 Extend `_dispatch_injection` in `_management_state_injection.py` to look up `(service, resource_type)` in the registry and call `tracker.set_state` / `tracker.remove`; define state-to-action mapping (terminal states → set_state, "deleted"/"removed" → remove)
- [x] 1.4 Add `tracker_registry` parameter (default empty dict) to `create_management_router` in `management.py`; thread through to `_register_state_routes`
- [x] 1.5 Thread `TrackerRegistry` from `_ldk_providers_extended.py` → `_register_experimental_providers` → each factory lambda
- [x] 1.6 Register `_cluster_tracker` and `_instance_tracker` in `cluster_db_service.py` as `(service, "cluster")` and `(service, "instance")` — requires passing `registry` and `service_name` to the factory
- [x] 1.7 Register domain trackers in `opensearch/routes.py` and `elasticsearch/routes.py`
- [x] 1.8 Register trackers in `memorydb/routes.py`, `elasticache/routes.py`, `s3tables/routes.py`
- [x] 1.9 Unit tests for `TrackerRegistry` dispatch in `core/tests/unit/` — cover inject set_state, inject remove, unknown service fallback
- [x] 1.10 Integration test in `core/tests/integration/` — verify `PUT /state/neptune/cluster/id` with body `{"state": "available"}` calls `_cluster_tracker.set_state`
- [x] 1.11 Replace all `pytest.skip("Cannot trigger internal X cluster/instance/domain creation/deletion completion")` when steps with `lws_session.inject_state(service, resource_type, id, "available"/"deleted")` — covers neptune, rds, docdb, opensearch, elasticsearch, elasticache, memorydb, s3tables (~100 steps)

## Phase 2: Snapshot Lifecycle Tracker

- [x] 2.1 Add `_snapshot_tracker = ResourceStateTracker(_lc)` to `create_cluster_db_app` in `cluster_db_service.py`
- [x] 2.2 Register `_snapshot_tracker` as `(service, "snapshot")` in the `TrackerRegistry`
- [x] 2.3 Update `handle_create_db_cluster_snapshot` in `_cluster_db_extra_handlers.py` to call `_snapshot_tracker.set_state(sid, "CREATING")` then `schedule_transition(sid, "available", create_dwell_ms)` when `create_dwell_ms > 0`; otherwise set directly to "available"
- [x] 2.4 Update `handle_delete_db_cluster_snapshot` similarly for DELETING → removed
- [x] 2.5 Update `describe_db_cluster_snapshots` to read snapshot status from `_snapshot_tracker` if available, falling back to the status field on `_DBClusterSnapshot`
- [x] 2.6 Thread `_snapshot_tracker` through to snapshot handlers (pass alongside `_cluster_tracker` and `_instance_tracker`)
- [x] 2.7 Unit tests for snapshot tracker transitions — CREATING → available via dwell, CREATING → available via inject, DELETING → removed
- [x] 2.8 Replace all `pytest.skip("Cannot trigger internal X snapshot creation/deletion completion")` when steps with `lws_session.inject_state(service, "snapshot", id, "available"/"deleted")` — covers neptune, rds, docdb (~30 steps)

## Phase 3a: Cluster Operational State Handlers (Neptune, RDS, DocumentDB)

- [ ] 3.1 Add `stop_db_cluster` handler to `cluster_db_service.py` — validates cluster is AVAILABLE, places in STOPPING state, schedules transition to STOPPED after `modify_dwell_ms`
- [ ] 3.2 Add `start_db_cluster` handler — validates cluster is STOPPED, places in STARTING state, schedules transition to AVAILABLE
- [ ] 3.3 Add `restore_db_cluster_from_snapshot` handler — creates new cluster in RESTORING state, schedules transition to AVAILABLE; validates snapshot exists
- [ ] 3.4 Add `reboot_db_instance` handler — validates instance is AVAILABLE, places in REBOOTING state, schedules transition to AVAILABLE
- [ ] 3.5 Add `failover_db_cluster` handler — places cluster in FAILING_OVER state, schedules transition to AVAILABLE
- [ ] 3.6 Register operational state changes in the same `_cluster_tracker` / `_instance_tracker` (already in TrackerRegistry from Phase 1)
- [ ] 3.7 Update read guards in `_check_cluster_read_lifecycle` to block operations when cluster is in STOPPING/STOPPED/STARTING/RESTORING/FAILING_OVER states
- [ ] 3.8 Unit tests for each new handler: stop→STOPPING→STOPPED, start→STARTING→AVAILABLE, restore→RESTORING→AVAILABLE, reboot→REBOOTING→AVAILABLE, failover→FAILING_OVER→AVAILABLE; inject_state completion for each
- [ ] 3.9 Replace `pytest.skip("Cannot trigger internal Neptune/RDS/DocumentDB cluster stop/start/restore/reboot/failover")` with real implementations using lifecycle dwell + inject_state (~40 steps across neptune, rds, docdb)

## Phase 3b: ElastiCache and MemoryDB Operational States

- [ ] 3.10 Add MODIFYING state to ElastiCache cluster tracker for `modify_cache_cluster`; add snapshot CREATING/DELETING; add ACL update MODIFYING for user/ACL operations
- [ ] 3.11 Add DELETING/MODIFYING/UPDATING states to MemoryDB trackers for cluster, snapshot, user, ACL
- [ ] 3.12 Register operational trackers (already in TrackerRegistry from Phase 1)
- [ ] 3.13 Unit tests for each new ElastiCache + MemoryDB state transition
- [ ] 3.14 Replace `pytest.skip` for ElastiCache and MemoryDB completion events (~35 steps)

## Phase 3c: OpenSearch and Elasticsearch Operational States

- [ ] 3.15 Add PROCESSING / UPGRADING states to the domain tracker for OpenSearch and Elasticsearch — set on modify/upgrade operations
- [ ] 3.16 Add `update_domain_config` and `upgrade_elasticsearch_domain` handlers that set PROCESSING state and schedule transition to ACTIVE
- [ ] 3.17 Unit tests for domain processing state transitions
- [ ] 3.18 Replace `pytest.skip` for OpenSearch and Elasticsearch completion events (~25 steps)

## Phase 3d: S3Tables Operational States

- [ ] 3.19 Add MODIFYING state for S3Tables bucket/namespace/table modify operations
- [ ] 3.20 Register in TrackerRegistry and unit test
- [ ] 3.21 Replace `pytest.skip` for S3Tables completion events (~13 steps)
