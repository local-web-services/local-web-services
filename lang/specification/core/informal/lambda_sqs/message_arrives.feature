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
    And a message slot is available
    When a message arrives in the "sqs" "queue"
    Then the message will be "AVAILABLE" for processing
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

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
  Scenario: a message arrives in the "sqs" "queue" fails when no message slot is available
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And no message slot is available
    When a message arrives in the "sqs" "queue"
    Then the operation is rejected
