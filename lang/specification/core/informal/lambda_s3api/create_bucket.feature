@lambdas3api @generated
Feature: LambdaS3api - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the "s3" "bucket" did not already exist
    When a "s3" "bucket" is created
    Then the "s3" "bucket" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the "s3" "bucket" already existed
    Given the "s3" "bucket" already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
