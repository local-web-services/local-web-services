# Change: Remove Python e2e skips — capacity exhaustion and lifecycle state control

## Why

~170 Python e2e step definitions are currently skipped with `pytest.skip()` because they require either (a) exhausting a service's capacity slots or (b) placing a resource into a non-ACTIVE/non-AVAILABLE/CREATING/DELETING state. Both capabilities now exist in the core (`AwsCapacityConfig` management API and `ResourceLifecycleConfig`/`ResourceStateTracker`) but are not yet exposed through the SDK test session or wired to all services. Removing these skips requires: extending the SDK session with capacity and lifecycle control helpers, and wiring lifecycle support to all remaining services.

## What Changes

- **SDK**: Add `lws_session.set_capacity(service, slots=0)` and `lws_session.reset_capacity(service)` to the `LwsSession` class so e2e step definitions can exhaust or restore capacity before/after tests.
- **SDK**: Add `lws_session.set_resource_lifecycle(service, resource_name, state)` and `lws_session.reset_resource_lifecycle(service, resource_name)` to allow step definitions to place a named resource into CREATING, DELETING, or a custom non-ACTIVE state.
- **Core**: Extend `ResourceLifecycleConfig` / `ResourceStateTracker` wiring to services that currently lack it: Lambda, OpenSearch, Elasticsearch, ElastiCache, Neptune, RDS, DocumentDB, MemoryDB, Glacier, Cognito, S3 Tables, S3 (bucket), ApiGateway (REST API), StepFunctions (state machine).
- **E2E steps**: Replace `pytest.skip()` with real implementations in ~90 capacity-related step definitions and ~80 lifecycle-related step definitions.

## Impact

- Affected specs: `python-lifecycle-parity`, `python-capacity-parity` (new delta)
- Affected code: `lang/python/sdk/src/lws_testing/session.py`, `lang/python/core/src/lws/providers/*/routes.py` (lifecycle wiring), `lang/python/sdk/tests/e2e/*/given/*.py`, `lang/python/sdk/tests/e2e/*/when/*.py`, `lang/python/sdk/tests/e2e/*/then/*.py`
- No breaking changes.
