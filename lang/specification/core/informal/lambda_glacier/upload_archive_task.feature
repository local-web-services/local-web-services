@lambdaglacier @generated
Feature: LambdaGlacier - The Lambda Function Uploads An Archive To An Existing Vault And Succeeds

  # Generated from FizzBee spec: lambda_glacier.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ArchiveReferencesExistingVault

  Background:
    Given the system is initialized

  @minimal @happy @upload_archive_task @internal
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds
    Given an invocation is "IN_PROGRESS"
    And the vault "EXISTS"
    And an archive slot is available
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then the archive "EXISTS" in the vault and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing archive references a vault that exists

  @guard @negative @upload_archive_task @internal
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then the operation is rejected

  @guard @negative @upload_archive_task @internal
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds fails when the vault does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the vault does not exist or is "DELETED"
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then the operation is rejected

  @guard @negative @upload_archive_task @internal
  Scenario: the Lambda function uploads an archive to an existing vault and succeeds fails when no archive slot is available
    Given an invocation is "IN_PROGRESS"
    And the vault "EXISTS"
    And no archive slot is available
    When the Lambda function uploads an archive to an existing vault and succeeds
    Then the operation is rejected
