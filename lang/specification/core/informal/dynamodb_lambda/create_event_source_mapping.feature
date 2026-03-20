@dynamodblambda @generated
Feature: DynamodbLambda - A Lambda Event Source Mapping Is Created To Process The Dynamodb Stream

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And the function exists
    And the function is "ACTIVE"
    And the event source mapping does not already exist
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the event source mapping is "ENABLED" and will poll the stream for change records
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the table does not exist
    Given the table does not exist
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected

  @standard @negative @create_event_source_mapping @lifecycle
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the table does not have a stream enabled
    Given the table exists
    And the table is "ACTIVE"
    And the table does not have a stream enabled
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the function does not exist
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And the function does not exist
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected

  @standard @negative @create_event_source_mapping @lifecycle
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the function is not "ACTIVE"
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And the function exists
    And the function is not "ACTIVE"
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created to process the DynamoDB Stream fails when the event source mapping already exists
    Given the table exists
    And the table is "ACTIVE"
    And the table has a stream enabled
    And the function exists
    And the function is "ACTIVE"
    And the event source mapping already exists
    When a Lambda event source mapping is created to process the DynamoDB Stream
    Then the operation is rejected
