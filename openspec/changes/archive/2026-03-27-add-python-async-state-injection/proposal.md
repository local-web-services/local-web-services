# Change: Add Python async state injection — pre-set in-flight execution and invocation states for sequence tests

## Why

~80 e2e step definitions are skipped because they need to establish a mid-execution state as a test precondition. Sequence scenarios test "given an execution is RUNNING, when X happens, then Y" — but lws has no way to inject a resource into an intermediate asynchronous state (RUNNING execution, IN_PROGRESS invocation, MODIFYING cluster, RESTORING snapshot, etc.) without actually running the full preceding operation chain. A state injection management API would allow test setup steps to directly place resources into any intermediate state.

## What Changes

- **Management API — state injection**: Add `PUT /management/state/{service}/{resource_type}/{resource_id}` accepting a `{"state": "RUNNING"}` body. This directly sets the in-memory state of a named resource without running the operation that would normally transition it there.
- **SDK**: Add `lws_session.inject_state(service, resource_type, resource_id, state)` and `lws_session.clear_injected_state(service, resource_type, resource_id)` helpers.
- **StepFunctions**: Support injecting RUNNING, SUCCEEDED, FAILED, TIMED_OUT states for executions.
- **Lambda**: Support injecting IN_PROGRESS, SUCCEEDED, FAILED invocation states.
- **Cluster services** (ElastiCache, Neptune, RDS, DocumentDB, MemoryDB): Support injecting MODIFYING, RESTORING, SNAPSHOTTING, REBOOTING, STOPPING, STOPPED states.
- **EventBridge**: Support injecting delivery states for emitted events.
- **E2E steps**: Replace `pytest.skip()` in ~80 sequence setup steps with `inject_state` calls.

## Impact

- Affected specs: `python-async-state-injection` (new)
- Affected code: `lang/python/core/src/lws/api/management.py`, `lang/python/core/src/lws/providers/stepfunctions/routes.py`, `lang/python/core/src/lws/providers/lambda_runtime/routes.py`, `lang/python/core/src/lws/providers/_shared/cluster_db_service.py`, `lang/python/sdk/src/lws_testing/session.py`
- No breaking changes to passing tests.
