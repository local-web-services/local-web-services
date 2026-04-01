@lambdadynamodb @generated
Feature: LambdaDynamodb - The "Lambda" "Function" Writes An Item To The "Dynamodb" "Table" During Invocation

  # Generated from FizzBee spec: lambda_dynamodb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ItemRequiresActiveTable

  Background:
    Given the system is initialized

  @minimal @happy @put_item
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And an item slot is available
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Then the item will exist in the "dynamodb" "table"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing item belongs to an "ACTIVE" table

  @guard @negative @put_item @lifecycle
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Then the operation is rejected

  @guard @negative @put_item
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation fails when the "dynamodb" "table" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "dynamodb" "table" did not exist
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Then the operation is rejected

  @guard @negative @put_item @lifecycle
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation fails when the "dynamodb" "table" was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Then the operation is rejected

  @guard @negative @put_item @capacity
  Scenario: the "lambda" "function" writes an item to the "dynamodb" "table" during invocation fails when no item slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And no item slot is available
    When the "lambda" "function" writes an item to the "dynamodb" "table" during invocation
    Then the operation is rejected
