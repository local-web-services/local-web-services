@lambdadynamodb @generated
Feature: LambdaDynamodb - The Lambda Invocation Fails

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given an invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation is "FAILED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
