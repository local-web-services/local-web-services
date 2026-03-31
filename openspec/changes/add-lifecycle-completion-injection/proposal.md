# Change: Add Lifecycle Completion Injection

## Why

253 e2e test scenarios are permanently skipped with "Cannot trigger internal X completion in lws" because `inject_state` writes to `AsyncStateStore` but provider lifecycle state is tracked by separate `ResourceStateTracker` objects buried in app closures. The two systems are never connected. Fixing this unlocks a large fraction of the `@sequence` and `@guard` tier tests.

## What Changes

- **Step 1 — TrackerRegistry**: Add a `TrackerRegistry` that maps `(service, resource_type)` to `ResourceStateTracker` instances. Provider app factories register their trackers at creation time. `_dispatch_injection` in `_management_state_injection.py` is extended to look up the correct tracker and call `set_state` / `schedule_transition` when `inject_state` is called. This unblocks create-completion and delete-completion events for all lifecycle-tracked services (Neptune, RDS, DocumentDB, OpenSearch, Elasticsearch, ElastiCache, MemoryDB, S3Tables).

- **Step 2 — Snapshot Lifecycle Tracker**: `cluster_db_service.py` currently has no tracker for snapshots — snapshot status is stored as a plain field on the data object, so snapshots are immediately "available". Add a `_snapshot_tracker` to `create_cluster_db_app`, register it in the `TrackerRegistry`, and wire snapshot create/delete handlers to use it. This unblocks snapshot-creation-completion and snapshot-deletion-completion events for Neptune, RDS, and DocumentDB.

- **Step 3 — Operational State Simulation**: Model the stop/start/restore/reboot/failover lifecycle for cluster services by adding new operational states (STOPPING, STOPPED, STARTING, MODIFYING, RESTORING, REBOOTING, FAILING_OVER) to the `ResourceStateTracker` for each service. Wire the corresponding API operations (StopDBCluster, StartDBCluster, ModifyDBCluster, RestoreDBClusterFromSnapshot, RebootDBInstance, FailoverDBCluster) to set these states. Register the operational-state trackers in the `TrackerRegistry` so `inject_state` can trigger state completions (e.g. STOPPING → STOPPED, MODIFYING → AVAILABLE). This is the largest piece and is phased per service: Neptune/RDS/DocumentDB first, then ElastiCache/MemoryDB/OpenSearch/Elasticsearch.

## Impact

- Affected specs: `python-async-state-injection`, `python-missing-service-features`
- Affected code:
  - `lang/python/core/src/lws/providers/_shared/aws_lifecycle.py` — new `TrackerRegistry`
  - `lang/python/core/src/lws/api/_management_state_injection.py` — extend `_dispatch_injection`
  - `lang/python/core/src/lws/api/management.py` — thread `TrackerRegistry` through
  - `lang/python/core/src/lws/providers/_shared/cluster_db_service.py` — register trackers + snapshot tracker
  - `lang/python/core/src/lws/providers/opensearch/routes.py` + `elasticsearch/routes.py` + `memorydb/routes.py` + `elasticache/routes.py` + `s3tables/routes.py` — register their trackers
  - `lang/python/core/src/lws/cli/_ldk_providers_extended.py` — thread `TrackerRegistry`
  - `lang/python/sdk/tests/e2e/` — replace ~253 `pytest.skip` when/given steps with real implementations
- Estimated skip reduction: ~100 from Step 1, ~30 from Step 2, ~120 from Step 3
