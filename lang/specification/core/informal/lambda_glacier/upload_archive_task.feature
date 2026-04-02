@lambdaglacier @generated
Feature: LambdaGlacier - The "Lambda" "Function" Uploads An "Glacier" "Archive" To An Existing Vault And Succeeds

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @upload_archive_task @internal
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "glacier" "vault" existed
    And an "glacier" "archive" slot is available
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Then the "glacier" "archive" will exist in the "glacier" "vault" and the invocation will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing archive references a "glacier" "vault" that exists

  @guard @negative @upload_archive_task @internal
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Then the operation is rejected

  @guard @negative @upload_archive_task @internal
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds fails when the "glacier" "vault" did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "glacier" "vault" did not exist or was "DELETED"
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Then the operation is rejected

  @guard @negative @upload_archive_task @internal
  Scenario: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds fails when no "glacier" "archive" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "glacier" "vault" existed
    And no "glacier" "archive" "slot" was "available"
    When the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds
    Then the operation is rejected
