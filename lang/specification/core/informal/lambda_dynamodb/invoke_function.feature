@lambdadynamodb @generated
Feature: LambdaDynamodb - The Lambda Function Is Invoked

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function
  Scenario: the Lambda function is invoked
    Given the function exists
    And the function is "ACTIVE"
    And an invocation slot is available
    When the Lambda function is invoked
    Then the invocation is "IN_PROGRESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @standard @negative @invoke_function
  Scenario: the Lambda function is invoked fails when the function does not exist
    Given the function does not exist
    When the Lambda function is invoked
    Then the operation is rejected

  @standard @negative @invoke_function @lifecycle
  Scenario: the Lambda function is invoked fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When the Lambda function is invoked
    Then the operation is rejected

  @standard @negative @internal @invoke_function @capacity
  Scenario: the Lambda function is invoked fails when no invocation slot is available
    Given the function exists
    And the function is "ACTIVE"
    And no invocation slot is available
    When the Lambda function is invoked
    Then the operation is rejected
