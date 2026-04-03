## MODIFIED Requirements

### Requirement: SDK State Injection Helpers

The `LwsSession` object SHALL expose `inject_state(service, resource_type, resource_id, state)` and `clear_injected_state(service, resource_type, resource_id)` that call the state injection management API.

When `inject_state` receives a 404 response whose body indicates the resource is not tracked (i.e. the tracker exists for the service/resource-type pair but the specific resource_id has not been created), it SHALL call `pytest.skip()` with a descriptive message rather than raising `RuntimeError`. This allows scenarios that depend on lifecycle state to be skipped gracefully when the precondition cannot be satisfied, rather than failing the test suite.

All other non-200 responses (e.g. 409 Conflict for invalid predecessor state, 400 Bad Request) SHALL continue to raise `RuntimeError`.

#### Scenario: State injected via SDK helper

- **GIVEN** an `LwsSession` is active
- **WHEN** `lws_session.inject_state("stepfunctions", "execution", "exec-1", "RUNNING")` is called
- **THEN** the StepFunctions provider reports the execution as RUNNING

#### Scenario: Inject state skips when resource not tracked

- **GIVEN** an `LwsSession` is active
- **AND** no resource with the given id has been created in the named service
- **WHEN** `lws_session.inject_state("elasticache", "cluster", "missing-id", "modifying")` is called
- **THEN** the test is skipped with a message indicating the resource is not tracked (rather than failing with RuntimeError)

#### Scenario: Inject state fails on conflict

- **GIVEN** an `LwsSession` is active
- **AND** a cluster exists and is in "available" state
- **WHEN** `lws_session.inject_state("elasticache", "cluster", "my-cluster", "deleting")` is called with an invalid predecessor state
- **THEN** `RuntimeError` is raised (409 responses are not silenced)

## ADDED Requirements

### Requirement: E2E Marker Expressions Do Not Exclude Lifecycle Tags

The Makefile `test-e2e-minimal`, `test-e2e-guard`, and `test-e2e-sequence` targets in both `lang/python/sdk/Makefile` and `lang/python/example/Makefile` SHALL use marker expressions that select only the tier tag (`minimal`, `guard`, or `sequence`) without excluding `@internal`, `@lifecycle`, or `@capacity` scenarios.

Scenarios tagged `@lifecycle`, `@internal`, or `@capacity` that cannot inject the required state SHALL be skipped at runtime by their step definitions (via `pytest.skip()` or `lws_session.inject_state()` graceful skip), not filtered out at the pytest collection level by the Makefile.

#### Scenario: Guard run includes lifecycle-tagged scenarios

- **WHEN** `make test-e2e-guard` is executed
- **THEN** all scenarios tagged `@guard` are collected, including those also tagged `@lifecycle`, `@internal`, or `@capacity`
- **AND** scenarios whose preconditions cannot be satisfied are reported as skipped, not absent
