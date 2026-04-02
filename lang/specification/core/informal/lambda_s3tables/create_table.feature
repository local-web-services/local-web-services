@lambdas3tables @generated
Feature: LambdaS3tables - A "S3 Tables" "Table" Is Created In The "S3 Tables" "Bucket"

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given the "s3 tables" "table" did not already exist
    And the "s3 tables" "bucket" was "ACTIVE"
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Then the "s3 tables" "table" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @guard @negative @create_table
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" fails when the "s3 tables" "table" already existed
    Given the "s3 tables" "table" already existed
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Then the operation is rejected

  @guard @negative @create_table @lifecycle
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" fails when the "s3 tables" "bucket" was not "ACTIVE"
    Given the "s3 tables" "table" did not already exist
    And the "s3 tables" "bucket" was not "ACTIVE"
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Then the operation is rejected
