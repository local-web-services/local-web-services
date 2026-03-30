@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Secret Is Created In Secrets Manager

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @create_secret
  Scenario: a secret is created in Secrets Manager
    Given the secret does not already exist
    When a secret is created in Secrets Manager
    Then the secret is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @guard @negative @create_secret
  Scenario: a secret is created in Secrets Manager fails when the secret already exists
    Given the secret already exists
    When a secret is created in Secrets Manager
    Then the operation is rejected
