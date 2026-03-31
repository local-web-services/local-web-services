@lambdasqs @generated
Feature: LambdaSqs - The Event Source Mapping Polls The Queue And Invokes The "Lambda" "Function"

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function"
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And an "AVAILABLE" message existed in the mapped queue
    And a "lambda" "invocation" slot is available
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the message will be "IN_FLIGHT" and a Lambda invocation will be "IN_PROGRESS"
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the event source mapping did not exist
    Given the event source mapping did not exist
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the event source mapping was not "ENABLED"
    Given the event source mapping existed
    And the event source mapping was not "ENABLED"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the mapped function was not "ACTIVE"
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was not "ACTIVE"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when no "AVAILABLE" message existed in the mapped queue
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And no "AVAILABLE" message existed in the mapped queue
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when no invocation slot is available
    Given the event source mapping existed
    And the event source mapping was "ENABLED"
    And the mapped function was "ACTIVE"
    And an "AVAILABLE" message existed in the mapped queue
    And no invocation slot is available
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected
