@dynamodblambda @generated
Feature: DynamodbLambda - A Change To The "Dynamodb" "Table" Produces A Stream Record

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @table_change_produces_record
  Scenario: a change to the "dynamodb" "table" produces a stream record
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And a "dynamodb" "record" "slot" was "available"
    When a change to the "dynamodb" "table" produces a stream record
    Then a "dynamodb" "change record" will be "AVAILABLE" for the "lambda" "event source mapping" to process
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "dynamodb" "table" with streaming enabled

  @guard @negative @table_change_produces_record
  Scenario: a change to the "dynamodb" "table" produces a stream record fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a change to the "dynamodb" "table" produces a stream record
    Then the operation is rejected

  @guard @negative @table_change_produces_record @lifecycle
  Scenario: a change to the "dynamodb" "table" produces a stream record fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a change to the "dynamodb" "table" produces a stream record
    Then the operation is rejected

  @guard @negative @table_change_produces_record
  Scenario: a change to the "dynamodb" "table" produces a stream record fails when the "dynamodb" "table" does not have a stream enabled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" does not have a stream enabled
    When a change to the "dynamodb" "table" produces a stream record
    Then the operation is rejected

  @guard @negative @table_change_produces_record @capacity
  Scenario: a change to the "dynamodb" "table" produces a stream record fails when no "dynamodb" "record" "slot" was "available"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And no "dynamodb" "record" "slot" was "available"
    When a change to the "dynamodb" "table" produces a stream record
    Then the operation is rejected
