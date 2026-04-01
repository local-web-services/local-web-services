@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Running "Step Functions" "Execution" Reads An Active Secret And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @read_secret_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "secrets manager" "secret" existed and was "ACTIVE"
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "secrets manager" "secret" it read

  @guard @negative @read_secret_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Then the operation is rejected

  @guard @negative @read_secret_task_succeeds @internal
  Scenario: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds fails when the "secrets manager" "secret" did not exist or was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the "secrets manager" "secret" did not exist or was not "ACTIVE"
    When a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds
    Then the operation is rejected
