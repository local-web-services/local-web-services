@dynamodblambda @generated
Feature: DynamodbLambda - The Event Source Mapping Polls The Stream And Invokes The "Lambda" "Function" With The Record

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And an "AVAILABLE" record existed in the mapped table's stream
    And a "lambda" "invocation" slot is available
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the record will be being processed and a Lambda invocation will be "IN_PROGRESS"
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the event source mapping did not exist
    Given the event source mapping did not exist
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the event source mapping was not "ENABLED"
    Given the event source mapping existed
    And the event source mapping was not "ENABLED"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the mapped function was not "ACTIVE"
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was not "ACTIVE"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when no "AVAILABLE" record existed in the mapped table's stream
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And no "AVAILABLE" record existed in the mapped table's stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when no invocation slot is available
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And an "AVAILABLE" record existed in the mapped table's stream
    And no invocation slot is available
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected
