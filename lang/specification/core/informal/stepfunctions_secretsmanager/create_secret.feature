@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A "Secretsmanager" "Secret" Is Created In Secrets Manager

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager
    Given the "secretsmanager" "secret" did not already exist
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the "secrets manager" "secret" will be "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @guard @negative @create_secret
  Scenario: a "secretsmanager" "secret" is created in Secrets Manager fails when the "secretsmanager" "secret" already existed
    Given the "secretsmanager" "secret" already existed
    When a "secretsmanager" "secret" is created in Secrets Manager
    Then the operation is rejected
