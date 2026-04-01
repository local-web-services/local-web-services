@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A "Glacier" "Vault" Is Created

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a "glacier" "vault" is created
    Given the "glacier" "vault" did not already exist
    When a "glacier" "vault" is created
    Then the "glacier" "vault" will exist
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @guard @negative @create_vault
  Scenario: a "glacier" "vault" is created fails when the "glacier" "vault" already existed
    Given the "glacier" "vault" already existed
    When a "glacier" "vault" is created
    Then the operation is rejected
