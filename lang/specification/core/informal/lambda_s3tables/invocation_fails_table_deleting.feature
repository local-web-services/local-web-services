@lambdas3tables @generated
Feature: LambdaS3tables - The Lambda Function Fails To Write Because The Table Is Being Deleted

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_table_deleting
  Scenario: the Lambda function fails to write because the table is being deleted
    Given an invocation is "IN_PROGRESS"
    And the table is "DELETING"
    When the Lambda function fails to write because the table is being deleted
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @standard @negative @invocation_fails_table_deleting @lifecycle
  Scenario: the Lambda function fails to write because the table is being deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to write because the table is being deleted
    Then the operation is rejected

  @standard @negative @invocation_fails_table_deleting @lifecycle
  Scenario: the Lambda function fails to write because the table is being deleted fails when the table is not "DELETING"
    Given an invocation is "IN_PROGRESS"
    And the table is not "DELETING"
    When the Lambda function fails to write because the table is being deleted
    Then the operation is rejected
