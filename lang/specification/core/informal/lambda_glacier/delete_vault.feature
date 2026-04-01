@lambdaglacier @generated
Feature: LambdaGlacier - A "Glacier" "Vault" Is Deleted

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: a "glacier" "vault" is deleted
    Given the "glacier" "vault" existed
    And the "glacier" "vault" existed (not already "DELETED")
    When a "glacier" "vault" is deleted
    Then the "glacier" "vault" will be deleted and archive uploads will fail
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

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
