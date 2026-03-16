@lambdaglacier @generated
Feature: LambdaGlacier - A Glacier Vault Is Deleted

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: a Glacier vault is deleted
    Given the vault exists
    And the vault "EXISTS" (not already "DELETED")
    When a Glacier vault is deleted
    Then the vault is "DELETED" and archive uploads will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

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
