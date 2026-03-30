@lambdaglacier @generated
Feature: LambdaGlacier - A Glacier Vault Is Created

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a Glacier vault is created
    Given the vault does not already exist
    When a Glacier vault is created
    Then the vault "EXISTS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @guard @negative @create_vault
  Scenario: a Glacier vault is created fails when the vault already exists
    Given the vault already exists
    When a Glacier vault is created
    Then the operation is rejected
