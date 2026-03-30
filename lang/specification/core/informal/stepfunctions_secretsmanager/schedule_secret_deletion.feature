@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Secret Is Scheduled For Deletion

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @schedule_secret_deletion
  Scenario: a secret is scheduled for deletion
    Given the secret exists
    And the secret is "ACTIVE"
    When a secret is scheduled for deletion
    Then the secret is "PENDING_DELETION" and will cause task failures when read
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @guard @negative @schedule_secret_deletion
  Scenario: a secret is scheduled for deletion fails when the secret does not exist
    Given the secret does not exist
    When a secret is scheduled for deletion
    Then the operation is rejected

  @guard @negative @schedule_secret_deletion @lifecycle
  Scenario: a secret is scheduled for deletion fails when the secret is not "ACTIVE"
    Given the secret exists
    And the secret is not "ACTIVE"
    When a secret is scheduled for deletion
    Then the operation is rejected
