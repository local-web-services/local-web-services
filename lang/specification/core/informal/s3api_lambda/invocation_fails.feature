@s3apilambda @generated
Feature: S3apiLambda - The Lambda Invocation Fails

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation is "FAILED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @standard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
