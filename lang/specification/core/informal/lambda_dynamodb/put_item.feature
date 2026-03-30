@lambdadynamodb @generated
Feature: LambdaDynamodb - The Lambda Function Writes An Item To The Dynamodb Table During Invocation

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @put_item
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation
    Given an invocation is "IN_PROGRESS"
    And the table exists
    And the table is "ACTIVE"
    And an item slot is available
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then the item "EXISTS" in the table
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @put_item @lifecycle
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then the operation is rejected

  @guard @negative @put_item
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation fails when the table does not exist
    Given an invocation is "IN_PROGRESS"
    And the table does not exist
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then the operation is rejected

  @guard @negative @put_item @lifecycle
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation fails when the table is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the table exists
    And the table is not "ACTIVE"
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then the operation is rejected

  @guard @negative @internal @put_item @capacity
  Scenario: the Lambda function writes an item to the DynamoDB table during invocation fails when no item slot is available
    Given an invocation is "IN_PROGRESS"
    And the table exists
    And the table is "ACTIVE"
    And no item slot is available
    When the Lambda function writes an item to the DynamoDB table during invocation
    Then the operation is rejected
