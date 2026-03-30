@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Running Execution Fails Because The Glacier Vault Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @glacier_task_fails @internal
  Scenario: a running execution fails because the Glacier vault has been deleted
    Given an execution is "RUNNING"
    And the vault is "DELETED"
    When a running execution fails because the Glacier vault has been deleted
    Then the execution is "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @guard @negative @glacier_task_fails @internal
  Scenario: a running execution fails because the Glacier vault has been deleted fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails because the Glacier vault has been deleted
    Then the operation is rejected

  @guard @negative @glacier_task_fails @internal
  Scenario: a running execution fails because the Glacier vault has been deleted fails when the vault is not "DELETED"
    Given an execution is "RUNNING"
    And the vault is not "DELETED"
    When a running execution fails because the Glacier vault has been deleted
    Then the operation is rejected
