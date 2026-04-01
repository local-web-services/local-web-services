@lambdasqs @generated
Feature: LambdaSqs - A Message Arrives In The "Sqs" "Queue"

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @message_arrives @internal
  Scenario: a message arrives in the "sqs" "queue"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And a "sqs" "message" "slot" was "available"
    When a message arrives in the "sqs" "queue"
    Then the "sqs" "message" will be "AVAILABLE" for processing
    And every "IN_PROGRESS" "lambda" "function" invocation was initiated by an "ENABLED" "lambda" "event source mapping"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "AVAILABLE" or "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "ENABLED" "lambda" "event source mapping" references an "ACTIVE" "sqs" "queue"

  @guard @negative @message_arrives @internal
  Scenario: a message arrives in the "sqs" "queue" fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When a message arrives in the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @message_arrives @internal
  Scenario: a message arrives in the "sqs" "queue" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a message arrives in the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @message_arrives @internal
  Scenario: a message arrives in the "sqs" "queue" fails when no "sqs" "message" "slot" was "available"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And no "sqs" "message" "slot" was "available"
    When a message arrives in the "sqs" "queue"
    Then the operation is rejected
