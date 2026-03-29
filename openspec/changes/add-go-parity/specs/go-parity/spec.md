## ADDED Requirements

### Requirement: Go Chaos Management API

The Go LWS server SHALL expose `PUT /_ldk/chaos/{service}` accepting `{"error_rate": float, "latency_ms": int}`, `DELETE /_ldk/chaos/{service}` to reset, and `GET /_ldk/chaos/{service}` to retrieve current chaos configuration. When chaos is configured, all requests to the specified service provider SHALL be intercepted and either rejected (if `error_rate` probability is met) or delayed by `latency_ms` before proceeding.

#### Scenario: Chaos configuration accepted and stored

- **WHEN** `PUT /_ldk/chaos/lambda` is called with `{"error_rate": 1.0, "latency_ms": 0}`
- **THEN** HTTP 200 is returned and subsequent Lambda invocations fail with a fault error

#### Scenario: Chaos reset restores normal operation

- **GIVEN** chaos is configured for a service
- **WHEN** `DELETE /_ldk/chaos/lambda` is called
- **THEN** subsequent Lambda invocations succeed normally

#### Scenario: Chaos configuration retrieved

- **GIVEN** chaos has been configured for a service
- **WHEN** `GET /_ldk/chaos/lambda` is called
- **THEN** the stored `error_rate` and `latency_ms` are returned

---

### Requirement: Go Fake Server Management API

The Go LWS server SHALL expose `POST /_ldk/fake` to register a named fake server endpoint, `GET /_ldk/fake` to list all registered fake servers, and `GET /_ldk/fake/{name}` to retrieve a specific fake server record.

#### Scenario: Fake server registered and retrievable

- **WHEN** `POST /_ldk/fake` is called with `{"name": "my-fake", "endpoint": "http://localhost:9999"}`
- **THEN** `GET /_ldk/fake/my-fake` returns the registered endpoint

#### Scenario: All fake servers listed

- **GIVEN** two fake servers have been registered
- **WHEN** `GET /_ldk/fake` is called
- **THEN** both fake server records are returned

---

### Requirement: Go State Injection Management API

The Go LWS server SHALL expose `PUT /_ldk/state/{service}/{resource_type}/{resource_id}` accepting `{"state": string}` to directly set in-memory resource state, `DELETE` to clear it, and `GET` to read it. State injection is used exclusively for test setup.

#### Scenario: StepFunctions execution injected as RUNNING

- **WHEN** `PUT /_ldk/state/stepfunctions/execution/my-exec` is called with `{"state": "RUNNING"}`
- **THEN** `DescribeExecution` for `my-exec` returns status RUNNING

#### Scenario: Injected state cleared

- **GIVEN** an execution has been injected into RUNNING state
- **WHEN** `DELETE /_ldk/state/stepfunctions/execution/my-exec` is called
- **THEN** `DescribeExecution` for `my-exec` returns NotFoundException

---

### Requirement: Go SDK Chaos and State Helpers

The Go SDK session type SHALL expose `SetChaos(service, errorRate float64, latencyMs int)`, `ResetChaos(service string)`, `GetChaosStatus(service string)`, `InjectState(service, resourceType, resourceID, state string)`, and `ClearInjectedState(service, resourceType, resourceID string)` methods that call the corresponding management API endpoints.

#### Scenario: SDK SetChaos causes operation failure

- **GIVEN** a Go SDK session is active
- **WHEN** `session.SetChaos("sqs", 1.0, 0)` is called
- **THEN** any subsequent SQS `SendMessage` call returns an error

#### Scenario: SDK InjectState sets execution status

- **GIVEN** a Go SDK session is active
- **WHEN** `session.InjectState("stepfunctions", "execution", "exec-1", "RUNNING")` is called
- **THEN** `DescribeExecution` for `exec-1` returns RUNNING status

---

### Requirement: Go Capacity Enforcement Completeness

Every Go provider handler (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch) SHALL enforce capacity limits configured via `PUT /_ldk/capacity/{service}` with `{"slots": 0}`, returning the service-specific error code when capacity is exhausted. The existing `/_ldk/capacity` endpoint in `management.go` SHALL be extended to cover all services that currently lack enforcement.

#### Scenario: DynamoDB PutItem rejected when capacity exhausted

- **WHEN** `PUT /_ldk/capacity/dynamodb` is called with `{"slots": 0}`
- **AND** `PutItem` is called
- **THEN** `ProvisionedThroughputExceededException` is returned

#### Scenario: Lambda Invoke rejected when concurrency capacity exhausted

- **WHEN** `PUT /_ldk/capacity/lambda` is called with `{"slots": 0}`
- **AND** `Invoke` is called synchronously
- **THEN** `TooManyRequestsException` is returned
