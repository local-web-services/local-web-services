# lambda-invocation-observability Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: Lambda Asynchronous Invocation Mode
The system SHALL support asynchronous Lambda invocation by respecting the `X-Invocation-Type: Event` request header, dispatching the function asynchronously, and returning HTTP 202 immediately.

#### Scenario: Async invocation returns 202
- **GIVEN** a Lambda function exists
- **WHEN** the function is invoked with `InvocationType=Event` (header `X-Invocation-Type: Event`)
- **THEN** the system returns HTTP 202 with an `X-Amzn-RequestId` header and does not wait for the function to complete

#### Scenario: Synchronous invocation still returns 200
- **GIVEN** a Lambda function exists
- **WHEN** the function is invoked without specifying `InvocationType` (defaults to `RequestResponse`)
- **THEN** the system returns HTTP 200 with the function response payload

### Requirement: Lambda Invocation State Tracking
The system SHALL track the lifecycle state of asynchronous Lambda invocations (whether triggered directly via `InvocationType=Event` or triggered by another service) from dispatch through to terminal state.

#### Scenario: Invocation starts in IN_PROGRESS state
- **GIVEN** an asynchronous Lambda invocation has been dispatched
- **WHEN** the invocation state is queried immediately after dispatch
- **THEN** the state is `IN_PROGRESS`

#### Scenario: Invocation transitions to SUCCESS
- **GIVEN** an asynchronous Lambda invocation is `IN_PROGRESS`
- **WHEN** the Lambda function returns successfully
- **THEN** the invocation state transitions to `SUCCESS`

#### Scenario: Invocation transitions to FAILED
- **GIVEN** an asynchronous Lambda invocation is `IN_PROGRESS`
- **WHEN** the Lambda function throws an unhandled exception
- **THEN** the invocation state transitions to `FAILED`

### Requirement: Lambda Trigger Invocation Lifecycle
The system SHALL record and expose the invocation lifecycle for Lambda functions triggered by other services (SNS, S3, EventBridge, Cognito, DynamoDB streams).

#### Scenario: Service-triggered invocation is observable
- **GIVEN** a Lambda function is configured as a target for a service trigger (SNS subscription, S3 notification, EventBridge rule, etc.)
- **WHEN** the triggering event occurs
- **THEN** an invocation record is created and its state (`IN_PROGRESS` → `SUCCESS` | `FAILED`) is observable via the Lambda API

#### Scenario: Invocation record includes trigger source
- **GIVEN** a Lambda function was triggered by SNS
- **WHEN** the invocation record is retrieved
- **THEN** the record identifies the trigger source as SNS

