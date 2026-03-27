# python-cross-service-enforcement Specification

## Purpose
TBD - created by archiving change add-python-cross-service-enforcement. Update Purpose after archive.
## Requirements
### Requirement: EventBridge Event Routing Validation

The EventBridge provider SHALL validate that at least one enabled rule targets the destination resource and that the target is in ACTIVE state before routing a `put_events` call. If no enabled rule exists, or the target is not ACTIVE, the call SHALL be rejected with an appropriate error.

#### Scenario: put_events rejected — no enabled rule targeting the queue

- **GIVEN** an EventBridge bus exists with no enabled rule targeting the SQS queue
- **WHEN** `put_events` is called
- **THEN** the operation is rejected

#### Scenario: put_events rejected — target queue not ACTIVE

- **GIVEN** an EventBridge bus exists with an enabled rule targeting the queue
- **AND** the target queue is in CREATING or DELETING state
- **WHEN** `put_events` is called
- **THEN** the operation is rejected

#### Scenario: put_events succeeds — enabled rule with ACTIVE target

- **GIVEN** an enabled rule exists targeting an ACTIVE queue
- **WHEN** `put_events` is called
- **THEN** the event is delivered successfully

### Requirement: EventBridge Target Existence Validation

The EventBridge provider SHALL validate that referenced targets (Lambda function, DynamoDB table, SQS queue, SNS topic, state machine) exist when creating rules or configuring targets via `put_rule` / `put_targets`.

#### Scenario: put_targets rejected — Lambda function does not exist

- **GIVEN** a rule exists
- **WHEN** `put_targets` is called referencing a Lambda function that does not exist
- **THEN** the operation is rejected

#### Scenario: put_targets accepted — all targets exist

- **GIVEN** all referenced targets exist and are ACTIVE
- **WHEN** `put_targets` is called
- **THEN** the targets are configured successfully

### Requirement: SNS Delivery Pre-conditions

The SNS provider SHALL reject `publish` when no confirmed subscription exists for the topic. The SNS provider SHALL reject `subscribe` (SQS protocol) when the target queue is in CREATING or DELETING state. SNS publish SHALL fail to deliver to an SQS queue that is not ACTIVE.

#### Scenario: publish rejected — no confirmed subscription

- **GIVEN** a topic exists with no confirmed subscriptions
- **WHEN** `publish` is called
- **THEN** the operation is rejected

#### Scenario: subscribe rejected — queue not ACTIVE

- **GIVEN** an SQS queue is in CREATING state
- **WHEN** `subscribe` is called with protocol=sqs targeting that queue
- **THEN** the operation is rejected

### Requirement: Cross-Service Event Bus Enforcement

Services that emit EventBridge events (Cognito, DocumentDB, ElastiCache, Neptune, RDS, SSM, SecretsManager) SHALL reject API operations that would generate events when the target EventBridge bus has been deleted.

#### Scenario: Operation rejected — event bus deleted

- **GIVEN** a service is configured to emit events to an EventBridge bus
- **AND** the bus has been deleted
- **WHEN** an operation that generates an event is performed
- **THEN** the operation is rejected

#### Scenario: Operation succeeds — event bus exists

- **GIVEN** the configured EventBridge bus exists and is ACTIVE
- **WHEN** an operation is performed
- **THEN** it succeeds and the event is emitted

### Requirement: SecretsManager and Cognito State Guards

SecretsManager SHALL reject `delete_secret` when the secret is already in PENDING_DELETION state. Cognito SHALL reject `admin_delete_user` on an already-deleted user and SHALL enforce UNCONFIRMED state checks on verification operations.

#### Scenario: delete_secret rejected — already PENDING_DELETION

- **GIVEN** a secret is in PENDING_DELETION state
- **WHEN** `delete_secret` is called
- **THEN** the operation is rejected with an appropriate error

#### Scenario: admin_delete_user rejected — user already deleted

- **GIVEN** a user has already been deleted
- **WHEN** `admin_delete_user` is called for that user
- **THEN** the operation is rejected

