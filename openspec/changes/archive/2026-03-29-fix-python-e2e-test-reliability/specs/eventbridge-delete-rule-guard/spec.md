## MODIFIED Requirements

### Requirement: EventBridge Target Existence Validation

The EventBridge provider SHALL validate that referenced targets (Lambda function, DynamoDB table, SQS queue, SNS topic, state machine) exist when creating rules or configuring targets via `put_rule` / `put_targets`. The provider SHALL also reject `delete_rule` with a `ValidationException` (HTTP 400) when the rule still has one or more registered targets; callers must remove all targets via `remove_targets` before deleting the rule.

#### Scenario: put_targets rejected — Lambda function does not exist

- **GIVEN** a rule exists
- **WHEN** `put_targets` is called referencing a Lambda function that does not exist
- **THEN** the operation is rejected

#### Scenario: put_targets accepted — all targets exist

- **GIVEN** all referenced targets exist and are ACTIVE
- **WHEN** `put_targets` is called
- **THEN** the targets are configured successfully

#### Scenario: delete_rule rejected — rule has active targets

- **GIVEN** a rule exists with one or more registered targets
- **WHEN** `delete_rule` is called for that rule
- **THEN** the operation is rejected with a `ValidationException`

#### Scenario: delete_rule succeeds — rule has no targets

- **GIVEN** a rule exists with no registered targets (or targets have been removed)
- **WHEN** `delete_rule` is called
- **THEN** the rule is deleted successfully
