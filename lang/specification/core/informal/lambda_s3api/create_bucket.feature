@lambdas3api @generated
Feature: LambdaS3api - An S3 Bucket Is Created

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: an S3 bucket is created
    Given the bucket does not already exist
    When an S3 bucket is created
    Then the bucket is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @standard @negative @create_bucket
  Scenario: an S3 bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 bucket is created
    Then the operation is rejected
