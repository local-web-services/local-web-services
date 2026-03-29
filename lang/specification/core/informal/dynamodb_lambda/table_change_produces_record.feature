@dynamodblambda @generated
Feature: DynamodbLambda - A Change To The Dynamodb Table Produces A Stream Record

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @table_change_produces_record
  Scenario: a change to the DynamoDB table produces a stream record
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And a record slot is available
    When a change to the DynamoDB table produces a stream record
    Then a change record is "AVAILABLE" for the event source mapping to process
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @standard @negative @table_change_produces_record
  Scenario: a change to the DynamoDB table produces a stream record fails when the table does not exist
    Given the table does not exist
    When a change to the DynamoDB table produces a stream record
    Then the operation is rejected

  @standard @negative @table_change_produces_record @lifecycle
  Scenario: a change to the DynamoDB table produces a stream record fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a change to the DynamoDB table produces a stream record
    Then the operation is rejected

  @standard @negative @table_change_produces_record
  Scenario: a change to the DynamoDB table produces a stream record fails when the table does not have a stream enabled
    Given the table exists
    And the table is "ACTIVE"
    And the table does not have a stream enabled
    When a change to the DynamoDB table produces a stream record
    Then the operation is rejected

  @standard @negative @internal @table_change_produces_record @capacity
  Scenario: a change to the DynamoDB table produces a stream record fails when no record slot is available
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And no record slot is available
    When a change to the DynamoDB table produces a stream record
    Then the operation is rejected
