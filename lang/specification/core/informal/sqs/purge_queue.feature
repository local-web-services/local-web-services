@sqs @generated
Feature: Sqs - All Messages In A Queue Are Purged

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @purge_queue
  Scenario: all messages in a queue are purged
    Given the queue exists
    And the queue is "ACTIVE"
    When all messages in a queue are purged
    Then all messages in the queue are "DELETED"
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @purge_queue
  Scenario: all messages in a queue are purged fails when the queue does not exist
    Given the queue does not exist
    When all messages in a queue are purged
    Then the operation is rejected

  @guard @negative @purge_queue @lifecycle
  Scenario: all messages in a queue are purged fails when the queue is not "ACTIVE"
    Given the queue exists
    And the queue is not "ACTIVE"
    When all messages in a queue are purged
    Then the operation is rejected
