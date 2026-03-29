## ADDED Requirements

### Requirement: Java Chaos Management API

The Java LWS server SHALL expose `PUT /_ldk/chaos/{service}` accepting `{"error_rate": double, "latency_ms": int}`, `DELETE /_ldk/chaos/{service}` to reset, and `GET /_ldk/chaos/{service}` to return current configuration. When chaos is configured, all requests to the specified service provider SHALL be intercepted: rejected at the configured `error_rate` probability, or delayed by `latency_ms` before dispatch.

#### Scenario: Chaos configuration stored and enforced

- **WHEN** `PUT /_ldk/chaos/sqs` is called with `{"error_rate": 1.0, "latency_ms": 0}`
- **THEN** subsequent SQS `SendMessage` calls return a fault error

#### Scenario: Chaos reset restores normal operation

- **GIVEN** chaos is configured for SQS
- **WHEN** `DELETE /_ldk/chaos/sqs` is called
- **THEN** subsequent SQS `SendMessage` calls succeed

#### Scenario: Chaos configuration retrievable

- **GIVEN** chaos has been configured
- **WHEN** `GET /_ldk/chaos/sqs` is called
- **THEN** the configured `error_rate` and `latency_ms` are returned

---

### Requirement: Java Fake Server Management API

The Java LWS server SHALL expose `POST /_ldk/fake` to register a named fake server endpoint, `GET /_ldk/fake` to list all registered fake servers, and `GET /_ldk/fake/{name}` to retrieve a specific record.

#### Scenario: Fake server registered and listed

- **WHEN** `POST /_ldk/fake` is called with `{"name": "my-fake", "endpoint": "http://localhost:9999"}`
- **THEN** `GET /_ldk/fake` returns a list that includes the registered record

#### Scenario: Specific fake server retrievable

- **GIVEN** a fake server named "my-fake" has been registered
- **WHEN** `GET /_ldk/fake/my-fake` is called
- **THEN** the registered endpoint is returned

---

### Requirement: Java Lifecycle Rules Management API

The Java LWS server SHALL expose `POST /_ldk/lifecycle` accepting a JSON object mapping service names to `{"enabled": boolean, "create_dwell_ms": int, "delete_dwell_ms": int}` to configure resource lifecycle timing, and `GET /_ldk/lifecycle` to return current rules. This mirrors the existing Go and Python `/_ldk/lifecycle` implementation.

#### Scenario: Lifecycle rule configured

- **WHEN** `POST /_ldk/lifecycle` is called with `{"dynamodb": {"enabled": true, "create_dwell_ms": 100}}`
- **THEN** HTTP 200 is returned

#### Scenario: Lifecycle rules retrievable

- **GIVEN** a lifecycle rule has been set
- **WHEN** `GET /_ldk/lifecycle` is called
- **THEN** the configured rule is present in the response

---

### Requirement: Java State Injection Management API

The Java LWS server SHALL expose `PUT /_ldk/state/{service}/{resourceType}/{resourceId}` accepting `{"state": string}`, `DELETE` to clear injected state, and `GET` to read it. State injection is for test setup only.

#### Scenario: StepFunctions execution injected as RUNNING

- **WHEN** `PUT /_ldk/state/stepfunctions/execution/exec-1` is called with `{"state": "RUNNING"}`
- **THEN** `DescribeExecution` for `exec-1` returns status `RUNNING`

#### Scenario: Injected state cleared

- **GIVEN** an execution is injected as RUNNING
- **WHEN** `DELETE /_ldk/state/stepfunctions/execution/exec-1` is called
- **THEN** `DescribeExecution` returns `ExecutionDoesNotExist`

---

### Requirement: Java Capacity Enforcement Completeness

Every Java provider handler (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch) SHALL enforce capacity limits configured via `PUT /_ldk/capacity/{service}` with `{"slots": 0}`, returning the service-specific error code when capacity is exhausted.

#### Scenario: DynamoDB PutItem rejected when capacity exhausted

- **WHEN** `PUT /_ldk/capacity/dynamodb` is called with `{"slots": 0}`
- **AND** `PutItem` is called
- **THEN** `ProvisionedThroughputExceededException` is returned

#### Scenario: Lambda Invoke rejected when concurrency capacity exhausted

- **WHEN** `PUT /_ldk/capacity/lambda` is called with `{"slots": 0}`
- **AND** `Invoke` is called synchronously
- **THEN** `TooManyRequestsException` is returned

---

### Requirement: Java SDK Chaos and State Helpers

The Java SDK `LwsSession` class SHALL expose `setChaos(String service, double errorRate, int latencyMs)`, `resetChaos(String service)`, `getChaosStatus(String service)`, `injectState(String service, String resourceType, String resourceId, String state)`, `clearInjectedState(String service, String resourceType, String resourceId)`, and `client("fake")` / `client("aws_fake")` returning properly-pointed SDK clients.

#### Scenario: setChaos causes SDK call failure

- **GIVEN** a Java LwsSession is active
- **WHEN** `session.setChaos("sqs", 1.0, 0)` is called
- **THEN** any subsequent SQS operation via the session returns an error

#### Scenario: Fake client accessible via SDK

- **GIVEN** a Java LwsSession is active
- **WHEN** `session.client("fake")` is called
- **THEN** a usable client is returned pointing at the fake service endpoint
