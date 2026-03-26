## ADDED Requirements

### Requirement: Capacity Config Defaults

The Python `AwsCapacityConfig` SHALL default to `slots=None` (unlimited). When `slots=None` all capacity checks SHALL pass and operations proceed normally. When `slots=0` the capacity is exhausted and operations that require a capacity slot SHALL be rejected with the service-specific error code. The default setting SHALL impose no behaviour change on existing tests.

#### Scenario: Operations succeed when capacity is unlimited

- **GIVEN** `slots=None` (default)
- **WHEN** any capacity-guarded operation is invoked
- **THEN** the operation succeeds normally

#### Scenario: Operations are rejected when capacity is exhausted

- **GIVEN** `slots=0`
- **WHEN** any capacity-guarded operation is invoked
- **THEN** the service-specific capacity error is returned

---

### Requirement: Capacity Control Plane Endpoint

The Python provider SHALL expose `PUT /_lws/control/{service}/capacity` with a JSON body `{"slots": 0}` to exhaust capacity and `DELETE /_lws/control/{service}/capacity` to reset to unlimited. `GET /_lws/control/{service}/capacity` SHALL return the current capacity config. The routing for this endpoint SHALL be implemented once in `_shared/capacity_control.py` and mounted by each provider, requiring no per-service boilerplate beyond registering the `AwsCapacityConfig` instance under the service name.

#### Scenario: PUT exhausts capacity

- **WHEN** `PUT /_lws/control/dynamodb/capacity` is called with `{"slots": 0}`
- **THEN** subsequent `PutItem` calls return `ProvisionedThroughputExceededException`

#### Scenario: DELETE resets capacity to unlimited

- **WHEN** `DELETE /_lws/control/dynamodb/capacity` is called after a `PUT` with `slots=0`
- **THEN** subsequent `PutItem` calls succeed normally

#### Scenario: GET returns current capacity config

- **WHEN** `GET /_lws/control/dynamodb/capacity` is called
- **THEN** the response body is `{"slots": 0}` or `{"slots": null}` reflecting the current setting

---

### Requirement: DynamoDB Capacity Enforcement

The Python DynamoDB provider SHALL reject all read and write operations when `slots=0`, returning `ProvisionedThroughputExceededException` (HTTP 400). Guarded operations: `PutItem`, `GetItem`, `UpdateItem`, `DeleteItem`, `Query`, `Scan`, `BatchWriteItem`, `BatchGetItem`, `TransactWriteItems`.

#### Scenario: PutItem is rejected when DynamoDB capacity is exhausted

- **WHEN** `slots=0` is set for `"dynamodb"`
- **AND** `PutItem` is called
- **THEN** `ProvisionedThroughputExceededException` is returned

#### Scenario: Query is rejected when DynamoDB capacity is exhausted

- **WHEN** `slots=0` is set for `"dynamodb"`
- **AND** `Query` is called
- **THEN** `ProvisionedThroughputExceededException` is returned

---

### Requirement: Lambda Capacity Enforcement

The Python Lambda provider SHALL maintain separate concurrency-slot and async-slot capacity configs. `Invoke` (synchronous) SHALL check concurrency-slot capacity and return `TooManyRequestsException` (HTTP 429) when exhausted. Async invocation and event-driven delivery paths SHALL check async-slot capacity.

#### Scenario: Invoke is rejected when Lambda concurrency capacity is exhausted

- **WHEN** `slots=0` is set for `"lambda"`
- **AND** `Invoke` is called synchronously
- **THEN** `TooManyRequestsException` is returned

---

### Requirement: SQS Capacity Enforcement

The Python SQS provider SHALL reject `SendMessage` and `SendMessageBatch` when `slots=0`, returning `OverLimit` (HTTP 400).

#### Scenario: SendMessage is rejected when SQS capacity is exhausted

- **WHEN** `slots=0` is set for `"sqs"`
- **AND** `SendMessage` is called
- **THEN** `OverLimit` is returned

---

### Requirement: SNS Capacity Enforcement

The Python SNS provider SHALL reject `Publish` and `Subscribe` when `slots=0`, returning `KMSThrottlingException` (HTTP 400). Cross-service delivery paths (SNS → Lambda, SNS → SQS) SHALL also check the destination service's capacity.

#### Scenario: Publish is rejected when SNS capacity is exhausted

- **WHEN** `slots=0` is set for `"sns"`
- **AND** `Publish` is called
- **THEN** `KMSThrottlingException` is returned

#### Scenario: SNS delivery to Lambda is rejected when Lambda capacity is exhausted

- **WHEN** `slots=0` is set for `"lambda"`
- **AND** an SNS message would be delivered to a Lambda subscriber
- **THEN** the delivery fails with a capacity error

---

### Requirement: Cognito Capacity Enforcement

The Python Cognito provider SHALL reject `InitiateAuth` and `SignUp` when `slots=0`, returning `TooManyRequestsException` (HTTP 400).

#### Scenario: InitiateAuth is rejected when Cognito capacity is exhausted

- **WHEN** `slots=0` is set for `"cognito"`
- **AND** `InitiateAuth` is called
- **THEN** `TooManyRequestsException` is returned

---

### Requirement: Step Functions Capacity Enforcement

The Python Step Functions provider SHALL reject `StartExecution` when `slots=0`, returning `ServiceUnavailableException` (HTTP 503).

#### Scenario: StartExecution is rejected when Step Functions capacity is exhausted

- **WHEN** `slots=0` is set for `"stepfunctions"`
- **AND** `StartExecution` is called
- **THEN** `ServiceUnavailableException` is returned

---

### Requirement: API Gateway Capacity Enforcement

The Python API Gateway provider SHALL return HTTP 429 with no body on all REST API invocation paths when `slots=0`.

#### Scenario: REST API invocation is rejected when API Gateway capacity is exhausted

- **WHEN** `slots=0` is set for `"apigateway"`
- **AND** a REST API endpoint is invoked
- **THEN** HTTP 429 is returned

---

### Requirement: Glacier Capacity Enforcement

The Python Glacier provider SHALL reject `InitiateJob` and `UploadArchive` when `slots=0`, returning `ServiceUnavailableException` (HTTP 503).

#### Scenario: InitiateJob is rejected when Glacier capacity is exhausted

- **WHEN** `slots=0` is set for `"glacier"`
- **AND** `InitiateJob` is called
- **THEN** `ServiceUnavailableException` is returned
