@lambdasqs @generated
Feature: LambdaSqs - The Lambda Invocation Fails

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then if the receive count is below the threshold the message will be "AVAILABLE" for reprocessing, otherwise it will be redriven to the dead-letter queue
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
