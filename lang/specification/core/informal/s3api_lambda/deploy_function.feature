@s3apilambda @generated
Feature: S3apiLambda - A Lambda Function Is Deployed

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a Lambda function is deployed
    Given the function does not already exist
    When a Lambda function is deployed
    Then the function is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @guard @negative @deploy_function
  Scenario: a Lambda function is deployed fails when the function already exists
    Given the function already exists
    When a Lambda function is deployed
    Then the operation is rejected
