@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Running "Step Functions" "Execution" Fails Because The Glacier Vault Has Been Deleted

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @glacier_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted
    Given a "step functions" "execution" was "RUNNING"
    And the "glacier" "vault" was "DELETED"
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    Then the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @guard @negative @glacier_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    Then the operation is rejected

  @guard @negative @glacier_task_fails @internal
  Scenario: a running "step functions" "execution" fails because the Glacier vault has been deleted fails when the "glacier" "vault" was not "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "glacier" "vault" was not "DELETED"
    When a running "step functions" "execution" fails because the Glacier vault has been deleted
    Then the operation is rejected
