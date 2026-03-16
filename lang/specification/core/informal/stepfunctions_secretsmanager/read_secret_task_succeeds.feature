@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Running Execution Reads An Active Secret And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @read_secret_task_succeeds @internal
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds
    Given an execution is "RUNNING"
    And the secret exists and is "ACTIVE"
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @standard @negative @read_secret_task_succeeds @internal
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then the operation is rejected

  @standard @negative @read_secret_task_succeeds @internal
  Scenario: a running execution reads an "ACTIVE" secret and the task succeeds fails when the secret does not exist or is not "ACTIVE"
    Given an execution is "RUNNING"
    And the secret does not exist or is not "ACTIVE"
    When a running execution reads an "ACTIVE" secret and the task succeeds
    Then the operation is rejected
