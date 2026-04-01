@dynamodblambda @generated
Feature: DynamodbLambda - The Event Source Mapping Polls The Stream And Invokes The "Lambda" "Function" With The Record

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And an "AVAILABLE" "dynamodb" "record" existed in the mapped table's stream
    And a "lambda" "invocation" "slot" was "available"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the "dynamodb" "record" will be being processed and a "lambda" "invocation" will be "IN_PROGRESS"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "dynamodb" "table" with streaming enabled

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the "lambda" "event source mapping" was not "ENABLED"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was not "ENABLED"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when the mapped "lambda" "function" was not "ACTIVE"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was not "ACTIVE"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when no "AVAILABLE" "dynamodb" "record" existed in the mapped table's stream
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And no "AVAILABLE" "dynamodb" "record" existed in the mapped table's stream
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the "lambda" "function" with the record fails when no "lambda" "invocation" "slot" was "available"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And an "AVAILABLE" "dynamodb" "record" existed in the mapped table's stream
    And no "lambda" "invocation" "slot" was "available"
    When the event source mapping polls the stream and invokes the "lambda" "function" with the record
    Then the operation is rejected
