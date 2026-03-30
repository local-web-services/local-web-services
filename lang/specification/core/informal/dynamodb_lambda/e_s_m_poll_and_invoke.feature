@dynamodblambda @generated
Feature: DynamodbLambda - The Event Source Mapping Polls The Stream And Invokes The Lambda Function With The Record

  # Generated from FizzBee spec: dynamodb_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, ESMReferencesActiveStream

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And an "AVAILABLE" record exists in the mapped table's stream
    And an invocation slot is available
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the record is being processed and a Lambda invocation is "IN_PROGRESS"
    And every "IN_PROGRESS" invocation was initiated by an "ENABLED" event source mapping
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" event source mapping references an "ACTIVE" table with streaming enabled

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record fails when the event source mapping does not exist
    Given the event source mapping does not exist
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record fails when the event source mapping is not "ENABLED"
    Given the event source mapping exists
    And the event source mapping is not "ENABLED"
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record fails when the mapped function is not "ACTIVE"
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is not "ACTIVE"
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record fails when no "AVAILABLE" record exists in the mapped table's stream
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And no "AVAILABLE" record exists in the mapped table's stream
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the stream and invokes the Lambda function with the record fails when no invocation slot is available
    Given the event source mapping exists
    And the event source mapping is "ENABLED"
    And the mapped function is "ACTIVE"
    And an "AVAILABLE" record exists in the mapped table's stream
    And no invocation slot is available
    When the event source mapping polls the stream and invokes the Lambda function with the record
    Then the operation is rejected
