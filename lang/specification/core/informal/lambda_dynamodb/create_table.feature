@lambdadynamodb @generated
Feature: LambdaDynamodb - A Dynamodb Table Is Created

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a DynamoDB table is created
    Given the table does not already exist
    When a DynamoDB table is created
    Then the table is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @create_table
  Scenario: a DynamoDB table is created fails when the table already exists
    Given the table already exists
    When a DynamoDB table is created
    Then the operation is rejected
