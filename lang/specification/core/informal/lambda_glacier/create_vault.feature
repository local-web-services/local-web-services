@lambdaglacier @generated
Feature: LambdaGlacier - A "Glacier" "Vault" Is Created

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a "glacier" "vault" is created
    Given the "glacier" "vault" did not already exist
    When a "glacier" "vault" is created
    Then the "glacier" "vault" will exist
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a "glacier" "vault" that exists

  @guard @negative @create_vault
  Scenario: a "glacier" "vault" is created fails when the "glacier" "vault" already existed
    Given the "glacier" "vault" already existed
    When a "glacier" "vault" is created
    Then the operation is rejected
