@dynamodblambda @generated
Feature: DynamodbLambda - A "Dynamodb" "Table" Is Created With Streaming Enabled

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @create_table_with_stream
  Scenario: a "dynamodb" "table" is created with streaming enabled
    Given the "dynamodb" "table" did not already exist
    When a "dynamodb" "table" is created with streaming enabled
    Then the "dynamodb" "table" will be "ACTIVE" and its stream will be ready to receive change records
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @guard @negative @create_table_with_stream
  Scenario: a "dynamodb" "table" is created with streaming enabled fails when the "dynamodb" "table" already existed
    Given the "dynamodb" "table" already existed
    When a "dynamodb" "table" is created with streaming enabled
    Then the operation is rejected
