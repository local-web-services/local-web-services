@lambdasqs @generated
Feature: LambdaSqs - A Message Arrives In The Sqs Queue

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @message_arrives @internal
  Scenario: a message arrives in the "SQS" queue
    Given the queue exists
    And the queue is "ACTIVE"
    And a message slot is available
    When a message arrives in the "SQS" queue
    Then the message is "AVAILABLE" for processing
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @standard @negative @message_arrives @internal
  Scenario: a message arrives in the "SQS" queue fails when the queue does not exist
    Given the queue does not exist
    When a message arrives in the "SQS" queue
    Then the operation is rejected

  @standard @negative @message_arrives @internal
  Scenario: a message arrives in the "SQS" queue fails when the queue is not "ACTIVE"
    Given the queue exists
    And the queue is not "ACTIVE"
    When a message arrives in the "SQS" queue
    Then the operation is rejected

  @standard @negative @message_arrives @internal
  Scenario: a message arrives in the "SQS" queue fails when no message slot is available
    Given the queue exists
    And the queue is "ACTIVE"
    And no message slot is available
    When a message arrives in the "SQS" queue
    Then the operation is rejected
