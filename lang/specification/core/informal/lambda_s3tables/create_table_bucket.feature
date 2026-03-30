@lambdas3tables @generated
Feature: LambdaS3tables - An S3 Table Bucket Is Created

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table_bucket
  Scenario: an S3 table bucket is created
    Given the bucket does not already exist
    When an S3 table bucket is created
    Then the bucket is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @guard @negative @create_table_bucket
  Scenario: an S3 table bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 table bucket is created
    Then the operation is rejected
