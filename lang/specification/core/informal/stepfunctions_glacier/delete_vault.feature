@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A "Glacier" "Vault" Is Deleted

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: a "glacier" "vault" is deleted
    Given the "glacier" "vault" existed
    And the "glacier" "vault" existed (not already "DELETED")
    When a "glacier" "vault" is deleted
    Then the "glacier" "vault" will be deleted and "SDK" task calls targeting it will fail
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "SUCCEEDED" "step functions" "execution" recorded which "glacier" "vault" it called

  @guard @negative @delete_vault
  Scenario: a "glacier" "vault" is deleted fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "vault" is deleted
    Then the operation is rejected

  @guard @negative @delete_vault @lifecycle
  Scenario: a "glacier" "vault" is deleted fails when the "glacier" "vault" is already "DELETED"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" is already "DELETED"
    When a "glacier" "vault" is deleted
    Then the operation is rejected
