@lambdaglacier @generated
Feature: LambdaGlacier - The "Lambda" "Function" Fails To Upload Because The "Glacier" "Vault" Has Been Deleted

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_vault_deleted
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "glacier" "vault" was "DELETED"
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Then the "lambda" "invocation" will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @guard @negative @invocation_fails_vault_deleted @lifecycle
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_vault_deleted @lifecycle
  Scenario: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted fails when the "glacier" "vault" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "glacier" "vault" was not "DELETED"
    When the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted
    Then the operation is rejected
