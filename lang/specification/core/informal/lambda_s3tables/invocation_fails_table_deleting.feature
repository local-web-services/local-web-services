@lambdas3tables @generated
Feature: LambdaS3tables - The "Lambda" "Function" Fails To Write Because The Table Is Being Deleted

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_table_deleting
  Scenario: the "lambda" "function" fails to write because the table is being deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the table was "DELETING"
    When the "lambda" "function" fails to write because the table is being deleted
    Then the invocation will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @invocation_fails_table_deleting @lifecycle
  Scenario: the "lambda" "function" fails to write because the table is being deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to write because the table is being deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_table_deleting @lifecycle
  Scenario: the "lambda" "function" fails to write because the table is being deleted fails when the table was not "DELETING"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the table was not "DELETING"
    When the "lambda" "function" fails to write because the table is being deleted
    Then the operation is rejected
