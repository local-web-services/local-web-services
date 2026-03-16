@stepfunctionssecretsmanager @generated
Feature: StepfunctionsSecretsmanager - A Running Execution Fails To Read The Secret Because It Is Pending Deletion

  # Generated from FizzBee spec: stepfunctions_secretsmanager.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionReadASecret

  Background:
    Given the system is initialized

  @minimal @happy @read_secret_task_fails @internal
  Scenario: a running execution fails to read the secret because it is pending deletion
    Given an execution is "RUNNING"
    And the secret is "PENDING_DELETION"
    When a running execution fails to read the secret because it is pending deletion
    Then the execution is "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which secret it read

  @standard @negative @read_secret_task_fails @internal
  Scenario: a running execution fails to read the secret because it is pending deletion fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails to read the secret because it is pending deletion
    Then the operation is rejected

  @standard @negative @read_secret_task_fails @internal
  Scenario: a running execution fails to read the secret because it is pending deletion fails when the secret is not pending deletion
    Given an execution is "RUNNING"
    And the secret is not pending deletion
    When a running execution fails to read the secret because it is pending deletion
    Then the operation is rejected
