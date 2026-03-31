@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Running "Step Functions" "Execution" Calls A "Glacier" "Vault" That Exists And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @glacier_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Given a "step functions" "execution" was "RUNNING"
    And the "glacier" "vault" existed
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @guard @negative @glacier_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Then the operation is rejected

  @guard @negative @glacier_task_succeeds @internal
  Scenario: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds fails when the "glacier" "vault" did not exist or was "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "glacier" "vault" did not exist or was "DELETED"
    When a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds
    Then the operation is rejected
