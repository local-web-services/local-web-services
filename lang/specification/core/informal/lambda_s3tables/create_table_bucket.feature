@lambdas3tables @generated
Feature: LambdaS3tables - A S3 Table Bucket Is Created

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table_bucket
  Scenario: a S3 table bucket is created
    Given the "s3" "bucket" did not already exist
    When a S3 table bucket is created
    Then the "s3" "bucket" will be "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @create_table_bucket
  Scenario: a S3 table bucket is created fails when the "s3" "bucket" already existed
    Given the "s3" "bucket" already existed
    When a S3 table bucket is created
    Then the operation is rejected
