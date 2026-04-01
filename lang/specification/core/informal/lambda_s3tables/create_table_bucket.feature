@lambdas3tables @generated
Feature: LambdaS3tables - A "S3 Tables" "Bucket" Is Created

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table_bucket
  Scenario: a "s3 tables" "bucket" is created
    Given the "s3" "bucket" did not already exist
    When a "s3 tables" "bucket" is created
    Then the "s3" "bucket" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @guard @negative @create_table_bucket
  Scenario: a "s3 tables" "bucket" is created fails when the "s3" "bucket" already existed
    Given the "s3" "bucket" already existed
    When a "s3 tables" "bucket" is created
    Then the operation is rejected
