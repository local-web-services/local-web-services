@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Running Execution Calls A Glacier Vault That Exists And The Task Succeeds

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @glacier_task_succeeds @internal
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Given an execution is "RUNNING"
    And the vault "EXISTS"
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @standard @negative @glacier_task_succeeds @internal
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then the operation is rejected

  @standard @negative @glacier_task_succeeds @internal
  Scenario: a running execution calls a Glacier vault that "EXISTS" and the task succeeds fails when the vault does not exist or is "DELETED"
    Given an execution is "RUNNING"
    And the vault does not exist or is "DELETED"
    When a running execution calls a Glacier vault that "EXISTS" and the task succeeds
    Then the operation is rejected
