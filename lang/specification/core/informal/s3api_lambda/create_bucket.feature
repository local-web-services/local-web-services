@s3apilambda @generated
Feature: S3apiLambda - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the bucket did not already exist
    When a "s3" "bucket" is created
    Then the bucket will be "ACTIVE" with no event notification configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the bucket already existed
    Given the bucket already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
