# Design: Lifecycle Completion Injection

## Context

LWS providers run as uvicorn servers started as asyncio tasks in a single Python process. Each provider's `ResourceStateTracker` objects are created inside the app factory closure and are only accessible from within that closure. The management server's `_dispatch_injection` currently hard-codes a single case for StepFunctions executions and has no general mechanism for reaching other providers' trackers.

## Goals / Non-Goals

- Goals:
  - Allow `inject_state(service, resource_type, resource_id, state)` to reach any provider's `ResourceStateTracker` directly
  - Enable snapshot lifecycle simulation via a new `_snapshot_tracker`
  - Model stop/start/restore/reboot/failover operations with injectable state transitions
  - Reduce the 253 permanently-skipped e2e tests to zero

- Non-Goals:
  - Cross-process state injection (all providers run in-process)
  - Adding completely new AWS service emulators (out of scope for this change)
  - Production use of the state injection API

## Decisions

### Decision: TrackerRegistry as a simple dict

`TrackerRegistry = dict[tuple[str, str], ResourceStateTracker]` where keys are `(service, resource_type)`. Defined in `aws_lifecycle.py` as a type alias. No new class needed — a plain dict satisfies all requirements.

**Why**: Minimal code, easy to test, no new abstractions. The dict is created once by the management layer and threaded to each provider factory. Each factory calls `registry[(service, resource_type)] = tracker` at creation time.

**Alternatives considered**:
- Global singleton registry: Rejected. Hard to test in isolation; risks shared state between test runs.
- Provider-level `inject_lifecycle_state(resource_type, resource_id, state)` method: Rejected. Requires changing the `Provider` interface contract and adds indirection without benefit.

### Decision: Thread TrackerRegistry from management layer down through CLI

`create_management_router` accepts an optional `tracker_registry: TrackerRegistry | None = None` parameter. The CLI wires the registry from `_ldk_providers_extended.py` when creating experimental provider factories. Each factory lambda receives the registry and registers its trackers after calling the app factory.

**Why**: Keeps injection optional (defaults to empty dict) so existing tests that don't use it are unaffected. Avoids globals.

### Decision: Dispatch by setting state + cancelling pending transition

When `inject_state` calls `tracker.set_state(resource_id, state)`, it sets the state immediately (cancelling any in-flight async dwell transition). This is the correct semantics: the test is saying "this resource is NOW in this state."

For lifecycle completions (CREATING → ACTIVE, DELETING → removed):
- If injected state is the terminal state ("available", "active"), call `tracker.set_state(resource_id, terminal)` — this cancels the dwell timer.
- If injected state is "deleted"/"removed", call `tracker.remove(resource_id)`.

### Decision: Snapshot tracker uses same ResourceStateTracker mechanism

Snapshot status (currently a plain field on `_DBClusterSnapshot`) is migrated to a `ResourceStateTracker`. The describe handler reads tracker state first; falls back to "available" for snapshots not in the tracker (backward compatibility for immediately-created snapshots).

**Alternative considered**: Keep snapshot status as a field and add a separate `inject_snapshot_status` dispatch. Rejected — inconsistent with how cluster/instance state works.

### Decision: Operational states use the same TrackerRegistry

Stop/start/restore/reboot/failover handlers write intermediate states (STOPPING, STARTING, etc.) to the same `ResourceStateTracker` used for CREATING/ACTIVE/DELETING. The tracker supports arbitrary state strings — no changes needed to the tracker itself.

**Alternatives considered**: Separate operational-state tracker per resource type. Rejected — adds complexity without benefit since the tracker already supports arbitrary state values.

## Risks / Trade-offs

- **CPD risk**: Adding tracker registration to multiple provider factories may produce similar boilerplate. Mitigation: extract a `_register_tracker(registry, service, resource_type, tracker)` helper or document a shared pattern.
- **Snapshot migration risk**: Changing snapshot status storage from field to tracker may break existing snapshot tests that expect immediate availability. Mitigation: Fall back to "available" if tracker has no entry for the snapshot.
- **Step 3 scope**: Operational state simulation requires new handlers for stop/start/restore/reboot in 7+ services (~50 new handler functions). Phase delivery: Neptune+RDS+DocumentDB first, then ElastiCache+MemoryDB, then OpenSearch+Elasticsearch.

## Open Questions

- None at time of writing. All implementation decisions are made above.
