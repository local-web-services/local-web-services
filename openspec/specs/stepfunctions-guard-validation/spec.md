# stepfunctions-guard-validation Specification

## Purpose
TBD - created by archiving change add-cross-service-dispatch-phase2. Update Purpose after archive.
## Requirements
### Requirement: StepFunctions State Machine Lifecycle Enforcement
The system SHALL reject `start_execution` when the target state machine is not in `ACTIVE` status.

#### Scenario: Execution rejected for non-ACTIVE state machine
- **GIVEN** a state machine exists but is not in ACTIVE status
- **WHEN** `start_execution` is called targeting that state machine
- **THEN** an appropriate error is returned and no execution is created

#### Scenario: Execution succeeds for ACTIVE state machine
- **GIVEN** a state machine is in ACTIVE status
- **WHEN** `start_execution` is called
- **THEN** the execution is created and begins running

### Requirement: StepFunctions Service Task Target Validation
The system SHALL validate that the target resource for a service task exists and is in an operable state before executing the task.

#### Scenario: SQS service task rejected when queue does not exist
- **GIVEN** a state machine has an SQS `sendMessage` service task targeting a queue that does not exist
- **WHEN** the service task is executed
- **THEN** the task fails with a resource-not-found error

#### Scenario: SQS service task rejected when queue is not ACTIVE
- **GIVEN** a state machine has an SQS `sendMessage` service task targeting a queue that exists but is not ACTIVE
- **WHEN** the service task is executed
- **THEN** the task fails with a lifecycle state error

#### Scenario: DynamoDB service task rejected when table does not exist
- **GIVEN** a state machine has a DynamoDB `putItem` service task targeting a table that does not exist
- **WHEN** the service task is executed
- **THEN** the task fails with a resource-not-found error

#### Scenario: SNS service task rejected when topic does not exist
- **GIVEN** a state machine has an SNS `publish` service task targeting a topic that does not exist
- **WHEN** the service task is executed
- **THEN** the task fails with a resource-not-found error

#### Scenario: S3 service task rejected when bucket does not exist
- **GIVEN** a state machine has an S3 `getObject` service task targeting a bucket that does not exist
- **WHEN** the service task is executed
- **THEN** the task fails with a resource-not-found error

### Requirement: StepFunctions Capacity Limit Enforcement
The system SHALL reject service task dispatch when the target service's capacity has been exhausted via the lws capacity configuration.

#### Scenario: Service task rejected when capacity exhausted
- **GIVEN** a state machine has a service task targeting a service
- **AND** that service's capacity has been exhausted via `lws_session.capacity(service).exhaust().apply()`
- **WHEN** the service task is executed
- **THEN** the task fails with a `ServiceUnavailableException`

