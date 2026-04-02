@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Running "Step Functions" "Execution" Fails To Read The "Secretsmanager" "Secret" Because It Is Pending Deletion

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @read_secret_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Given a "step functions" "execution" was "RUNNING"
    And the "secrets manager" "secret" was "PENDING_DELETION"
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Then the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "secrets manager" "secret" it read

  @guard @negative @read_secret_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Then the operation is rejected

  @guard @negative @read_secret_task_fails @internal
  Scenario: a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion fails when the "secrets manager" "secret" was not "PENDING_DELETION"
    Given a "step functions" "execution" was "RUNNING"
    And the "secrets manager" "secret" was not "PENDING_DELETION"
    When a running "step functions" "execution" fails to read the "secretsmanager" "secret" because it is pending deletion
    Then the operation is rejected
