@lambdasqs @generated
Feature: LambdaSqs - The "Lambda" "Function" Invocation Completes Successfully

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the "lambda" "invocation" will be "SUCCESS" and the "sqs" "message" will be deleted
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the operation is rejected
