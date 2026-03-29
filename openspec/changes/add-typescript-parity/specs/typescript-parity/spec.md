## ADDED Requirements

### Requirement: TypeScript Chaos Management API

The TypeScript LWS server SHALL expose `PUT /_ldk/chaos/:service` accepting `{"error_rate": number, "latency_ms": number}`, `DELETE /_ldk/chaos/:service` to reset, and `GET /_ldk/chaos/:service` to retrieve current chaos configuration. When chaos is configured, all requests to the specified service provider SHALL be intercepted and either rejected (if `error_rate` probability is met) or delayed by `latency_ms` milliseconds.

#### Scenario: Chaos configuration accepted

- **WHEN** `PUT /_ldk/chaos/sqs` is called with `{"error_rate": 1.0, "latency_ms": 0}`
- **THEN** HTTP 200 is returned and subsequent SQS `SendMessage` calls fail with a fault error

#### Scenario: Chaos reset restores operation

- **GIVEN** chaos is configured for SQS
- **WHEN** `DELETE /_ldk/chaos/sqs` is called
- **THEN** subsequent SQS `SendMessage` calls succeed

#### Scenario: Chaos state retrievable

- **GIVEN** chaos has been configured
- **WHEN** `GET /_ldk/chaos/sqs` is called
- **THEN** `{"error_rate": 1.0, "latency_ms": 0}` is returned

---

### Requirement: TypeScript Fake Server Management API

The TypeScript LWS server SHALL expose `POST /_ldk/fake` to register a named fake server endpoint, `GET /_ldk/fake` to list all registered fake servers, and `GET /_ldk/fake/:name` to retrieve a specific fake server record.

#### Scenario: Fake server registered

- **WHEN** `POST /_ldk/fake` is called with `{"name": "my-fake", "endpoint": "http://localhost:9999"}`
- **THEN** `GET /_ldk/fake/my-fake` returns the registered record

#### Scenario: Fake server list returned

- **GIVEN** two fake servers are registered
- **WHEN** `GET /_ldk/fake` is called
- **THEN** both records appear in the response array

---

### Requirement: TypeScript State Injection Management API

The TypeScript LWS server SHALL expose `PUT /_ldk/state/:service/:resourceType/:resourceId` accepting `{"state": string}`, `DELETE` to clear, and `GET` to read injected state. This API is for test setup only.

#### Scenario: StepFunctions execution injected as RUNNING

- **WHEN** `PUT /_ldk/state/stepfunctions/execution/exec-1` is called with `{"state": "RUNNING"}`
- **THEN** `DescribeExecution` for `exec-1` returns status `RUNNING`

#### Scenario: Injected state cleared

- **GIVEN** execution is injected as RUNNING
- **WHEN** `DELETE /_ldk/state/stepfunctions/execution/exec-1` is called
- **THEN** `DescribeExecution` returns `NotFoundException`

---

### Requirement: TypeScript Lifecycle Rules API

The TypeScript LWS server SHALL expose `POST /_ldk/lifecycle` accepting a map of service-name to `{"enabled": bool, "create_dwell_ms": int, "delete_dwell_ms": int}` to configure resource lifecycle timing, and `GET /_ldk/lifecycle` to return current rules. This mirrors the existing Go and Python implementation.

#### Scenario: Lifecycle rule configured

- **WHEN** `POST /_ldk/lifecycle` is called with `{"dynamodb": {"enabled": true, "create_dwell_ms": 100}}`
- **THEN** DynamoDB table creation transitions take at least 100ms

#### Scenario: Lifecycle rules retrievable

- **GIVEN** a lifecycle rule has been set
- **WHEN** `GET /_ldk/lifecycle` is called
- **THEN** the configured rule is returned in the response

---

### Requirement: TypeScript Capacity Enforcement Completeness

Every TypeScript provider handler (DynamoDB, Lambda, SQS, SNS, StepFunctions, Glacier, S3Tables, SecretsMgr, SSM, ElastiCache, MemoryDB, Neptune, DocDB, RDS, OpenSearch, Elasticsearch) SHALL enforce capacity limits configured via `PUT /_ldk/capacity/:service` with `{"slots": 0}`, returning the service-specific error code when capacity is exhausted.

#### Scenario: DynamoDB PutItem rejected when capacity exhausted

- **WHEN** `PUT /_ldk/capacity/dynamodb` is called with `{"slots": 0}`
- **AND** `PutItem` is called
- **THEN** `ProvisionedThroughputExceededException` is returned

#### Scenario: Lambda Invoke rejected when concurrency capacity exhausted

- **WHEN** `PUT /_ldk/capacity/lambda` is called with `{"slots": 0}`
- **AND** `Invoke` is called synchronously
- **THEN** `TooManyRequestsException` is returned

---

### Requirement: TypeScript SDK Chaos and State Helpers

The TypeScript SDK `LwsSession` class SHALL expose `setChaos(service: string, errorRate: number, latencyMs: number)`, `resetChaos(service: string)`, `getChaosStatus(service: string)`, `injectState(service: string, resourceType: string, resourceId: string, state: string)`, and `clearInjectedState(service: string, resourceType: string, resourceId: string)` methods, plus `client("fake")` and `client("aws_fake")` returning properly-pointed SDK clients.

#### Scenario: setChaos causes SDK call to fail

- **GIVEN** a TypeScript LwsSession is active
- **WHEN** `session.setChaos("sqs", 1.0, 0)` is called
- **THEN** any subsequent SQS operation via the session returns an error

#### Scenario: fake client accessible

- **GIVEN** a TypeScript LwsSession is active
- **WHEN** `session.client("fake")` is called
- **THEN** a usable client is returned pointing at the fake service endpoint
