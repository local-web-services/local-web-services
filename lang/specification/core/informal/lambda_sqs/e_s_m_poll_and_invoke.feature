@lambdasqs @generated
Feature: LambdaSqs - The Event Source Mapping Polls The Queue And Invokes The "Lambda" "Function"

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And an "AVAILABLE" message existed in the mapped queue
    And a "lambda" "invocation" slot is available
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the "sqs" "message" will be "IN_FLIGHT" and a "lambda" "invocation" will be "IN_PROGRESS"
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the "lambda" "event source mapping" was not "ENABLED"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was not "ENABLED"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when the mapped "lambda" "function" was not "ACTIVE"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was not "ACTIVE"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when no "AVAILABLE" message existed in the mapped queue
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And no "AVAILABLE" message existed in the mapped queue
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected

  @guard @negative @e_s_m_poll_and_invoke @internal
  Scenario: the event source mapping polls the queue and invokes the "lambda" "function" fails when no "lambda" "invocation" "slot" was "available"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "ENABLED"
    And the mapped "lambda" "function" was "ACTIVE"
    And an "AVAILABLE" message existed in the mapped queue
    And no "lambda" "invocation" "slot" was "available"
    When the event source mapping polls the queue and invokes the "lambda" "function"
    Then the operation is rejected
