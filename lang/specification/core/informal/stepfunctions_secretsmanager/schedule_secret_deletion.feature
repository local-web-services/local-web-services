@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A "Secretsmanager" "Secret" Is Scheduled For Deletion

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @schedule_secret_deletion
  Scenario: a "secretsmanager" "secret" is scheduled for deletion
    Given the secrets manager secret existed
    And the "secrets manager" "secret" was "ACTIVE"
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the "secrets manager" "secret" will be "PENDING_DELETION" and will cause task failures when read
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @guard @negative @schedule_secret_deletion
  Scenario: a "secretsmanager" "secret" is scheduled for deletion fails when the secrets manager secret did not exist
    Given the secrets manager secret did not exist
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the operation is rejected

  @guard @negative @schedule_secret_deletion @lifecycle
  Scenario: a "secretsmanager" "secret" is scheduled for deletion fails when the "secrets manager" "secret" was not "ACTIVE"
    Given the secrets manager secret existed
    And the "secrets manager" "secret" was not "ACTIVE"
    When a "secretsmanager" "secret" is scheduled for deletion
    Then the operation is rejected
