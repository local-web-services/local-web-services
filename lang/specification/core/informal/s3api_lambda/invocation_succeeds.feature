@s3apilambda @generated
Feature: S3apiLambda - The Lambda Invocation Completes Successfully

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @invocation_succeeds @internal
  Scenario: the Lambda invocation completes successfully fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation completes successfully
    Then the operation is rejected
