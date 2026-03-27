# python-async-state-injection Specification

## Purpose
TBD - created by archiving change add-python-async-state-injection. Update Purpose after archive.
## Requirements
### Requirement: State Injection Management API

The core management API SHALL expose `PUT /management/state/{service}/{resource_type}/{resource_id}` accepting `{"state": str}` to directly set the in-memory state of any named resource. It SHALL also expose `DELETE` to clear the injected state and `GET` to retrieve the current state. This API is intended solely for test setup and SHALL NOT be used in production workflows.

#### Scenario: Execution state injected as RUNNING

- **WHEN** `PUT /management/state/stepfunctions/execution/my-exec` is called with `{"state": "RUNNING"}`
- **THEN** `describe_execution` for `my-exec` returns status RUNNING

#### Scenario: Injected state cleared

- **GIVEN** an execution has been injected into RUNNING state
- **WHEN** `DELETE /management/state/stepfunctions/execution/my-exec` is called
- **THEN** the execution is no longer visible as RUNNING

### Requirement: SDK State Injection Helpers

The `LwsSession` object SHALL expose `inject_state(service, resource_type, resource_id, state)` and `clear_injected_state(service, resource_type, resource_id)` that call the state injection management API.

#### Scenario: State injected via SDK helper

- **GIVEN** an `LwsSession` is active
- **WHEN** `lws_session.inject_state("stepfunctions", "execution", "exec-1", "RUNNING")` is called
- **THEN** the StepFunctions provider reports the execution as RUNNING

### Requirement: StepFunctions Injected Execution States

The StepFunctions provider SHALL support injected states RUNNING, SUCCEEDED, FAILED, and TIMED_OUT for executions, as well as injected task completion states for all supported task service types (Lambda, SSM, S3, S3Tables, SNS, SQS, DynamoDB, RDS, OpenSearch, Neptune, MemoryDB, Glacier, Elasticsearch, ElastiCache, DocumentDB, Cognito).

#### Scenario: Running execution appears in list_executions

- **GIVEN** an execution has been injected as RUNNING
- **WHEN** `list_executions` is called with statusFilter=RUNNING
- **THEN** the injected execution is returned

### Requirement: Lambda Injected Invocation States

The Lambda provider SHALL support injected IN_PROGRESS, SUCCEEDED, and FAILED invocation records that appear in the invocation observability store.

#### Scenario: In-progress invocation blocks concurrency

- **GIVEN** an invocation is injected as IN_PROGRESS
- **WHEN** the concurrency limit is 1 and another invocation is attempted
- **THEN** the second invocation is rejected with TooManyRequestsException

### Requirement: Cluster Service Injected Operational States

The cluster services (ElastiCache, Neptune, RDS, DocumentDB, MemoryDB) SHALL support injected intermediate operational states (MODIFYING, SNAPSHOTTING, RESTORING, STOPPING, STOPPED, REBOOTING, FAILING_OVER) that are returned by describe operations and enforce appropriate operation restrictions.

#### Scenario: Modifying cluster rejects certain operations

- **GIVEN** a cluster is injected into MODIFYING state
- **WHEN** a modify operation is attempted
- **THEN** the operation is rejected with InvalidClusterState or equivalent error

