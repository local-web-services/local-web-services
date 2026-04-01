@lambdasqs @generated
Feature: LambdaSqs - The "Lambda" "Function" Invocation Fails

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then if the receive count is below the threshold the message will be "AVAILABLE" for reprocessing, otherwise it will be redriven to the dead-letter queue
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the operation is rejected
