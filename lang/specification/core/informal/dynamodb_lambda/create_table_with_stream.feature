@dynamodblambda @generated
Feature: DynamodbLambda - A Dynamodb Table Is Created With Streaming Enabled

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @create_table_with_stream
  Scenario: a DynamoDB table is created with streaming enabled
    Given the table does not already exist
    When a DynamoDB table is created with streaming enabled
    Then the table is "ACTIVE" and its stream is ready to receive change records
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @standard @negative @create_table_with_stream
  Scenario: a DynamoDB table is created with streaming enabled fails when the table already exists
    Given the table already exists
    When a DynamoDB table is created with streaming enabled
    Then the operation is rejected
