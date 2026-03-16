@lambdaglacier @generated
Feature: LambdaGlacier - The Lambda Function Fails To Upload Because The Vault Has Been Deleted

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_vault_deleted
  Scenario: the Lambda function fails to upload because the vault has been deleted
    Given an invocation is "IN_PROGRESS"
    And the vault is "DELETED"
    When the Lambda function fails to upload because the vault has been deleted
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @standard @negative @invocation_fails_vault_deleted @lifecycle
  Scenario: the Lambda function fails to upload because the vault has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to upload because the vault has been deleted
    Then the operation is rejected

  @standard @negative @invocation_fails_vault_deleted @lifecycle
  Scenario: the Lambda function fails to upload because the vault has been deleted fails when the vault is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the vault is not "DELETED"
    When the Lambda function fails to upload because the vault has been deleted
    Then the operation is rejected
