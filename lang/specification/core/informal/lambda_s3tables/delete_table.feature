@lambdas3tables @generated
Feature: LambdaS3tables - A "S3 Tables" "Table" Deletion Is Initiated

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a "s3 tables" "table" deletion is initiated
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When a "s3 tables" "table" deletion is initiated
    Then the "s3 tables" "table" will be "DELETING" and write operations will fail
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @guard @negative @delete_table
  Scenario: a "s3 tables" "table" deletion is initiated fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table" deletion is initiated
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a "s3 tables" "table" deletion is initiated fails when the "s3 tables" "table" is already "DELETING"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" is already "DELETING"
    When a "s3 tables" "table" deletion is initiated
    Then the operation is rejected
