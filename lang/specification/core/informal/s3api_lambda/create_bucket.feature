@s3apilambda @generated
Feature: S3apiLambda - An S3 Bucket Is Created

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: an S3 bucket is created
    Given the bucket does not already exist
    When an S3 bucket is created
    Then the bucket is "ACTIVE" with no event notification configured
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @create_bucket
  Scenario: an S3 bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 bucket is created
    Then the operation is rejected
