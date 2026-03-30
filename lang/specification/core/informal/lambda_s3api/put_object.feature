@lambdas3api @generated
Feature: LambdaS3api - The Lambda Function Writes An Object To The S3 Bucket During Invocation

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @put_object
  Scenario: the Lambda function writes an object to the S3 bucket during invocation
    Given an invocation is "IN_PROGRESS"
    And the bucket exists
    And the bucket is "ACTIVE"
    And an object slot is available
    When the Lambda function writes an object to the S3 bucket during invocation
    Then the object "EXISTS" in the bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @guard @negative @put_object @lifecycle
  Scenario: the Lambda function writes an object to the S3 bucket during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes an object to the S3 bucket during invocation
    Then the operation is rejected

  @guard @negative @put_object
  Scenario: the Lambda function writes an object to the S3 bucket during invocation fails when the bucket does not exist
    Given an invocation is "IN_PROGRESS"
    And the bucket does not exist
    When the Lambda function writes an object to the S3 bucket during invocation
    Then the operation is rejected

  @guard @negative @put_object @lifecycle
  Scenario: the Lambda function writes an object to the S3 bucket during invocation fails when the bucket is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the bucket exists
    And the bucket is not "ACTIVE"
    When the Lambda function writes an object to the S3 bucket during invocation
    Then the operation is rejected

  @guard @negative @internal @put_object @capacity
  Scenario: the Lambda function writes an object to the S3 bucket during invocation fails when no object slot is available
    Given an invocation is "IN_PROGRESS"
    And the bucket exists
    And the bucket is "ACTIVE"
    And no object slot is available
    When the Lambda function writes an object to the S3 bucket during invocation
    Then the operation is rejected
