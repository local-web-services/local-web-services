@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Glacier Vault Is Deleted

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: a Glacier vault is deleted
    Given the vault exists
    And the vault "EXISTS" (not already "DELETED")
    When a Glacier vault is deleted
    Then the vault is "DELETED" and "SDK" task calls targeting it will fail
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @standard @negative @delete_vault
  Scenario: a Glacier vault is deleted fails when the vault does not exist
    Given the vault does not exist
    When a Glacier vault is deleted
    Then the operation is rejected

  @standard @negative @delete_vault @lifecycle
  Scenario: a Glacier vault is deleted fails when the vault is already "DELETED"
    Given the vault exists
    And the vault is already "DELETED"
    When a Glacier vault is deleted
    Then the operation is rejected
