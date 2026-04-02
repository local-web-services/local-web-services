@dynamodblambda @generated
Feature: DynamodbLambda - A "Lambda" "Event Source Mapping" Is Created To Process The Dynamodb Stream

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "event source mapping" did not already exist
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the "lambda" "event source mapping" will be "ENABLED" and will poll the stream for change records
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "dynamodb" "table" with streaming enabled

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected

  @guard @negative @create_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "dynamodb" "table" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was not "ACTIVE"
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "dynamodb" "table" does not have a stream enabled
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" does not have a stream enabled
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "lambda" "function" did not exist
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And the "lambda" "function" did not exist
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected

  @guard @negative @create_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "lambda" "function" was not "ACTIVE"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created to process the DynamoDB Stream fails when the "lambda" "event source mapping" already existed
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    And the "dynamodb" "table" has a stream enabled
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "event source mapping" already existed
    When a "lambda" "event source mapping" is created to process the DynamoDB Stream
    Then the operation is rejected
