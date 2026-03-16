@stepfunctionsglacier @generated
Feature: StepfunctionsGlacier - A Glacier Vault Is Created

  # Generated from FizzBee spec: stepfunctions_glacier.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledAVault

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a Glacier vault is created
    Given the vault does not already exist
    When a Glacier vault is created
    Then the vault "EXISTS"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which vault it called

  @standard @negative @create_vault
  Scenario: a Glacier vault is created fails when the vault already exists
    Given the vault already exists
    When a Glacier vault is created
    Then the operation is rejected
