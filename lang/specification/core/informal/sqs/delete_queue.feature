@sqs @generated
Feature: Sqs - A Queue Is Deleted

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @delete_queue
  Scenario: a queue is deleted
    Given the queue exists
    And the queue is "ACTIVE"
    When a queue is deleted
    Then the queue is "DELETED" and its messages are removed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @delete_queue
  Scenario: a queue is deleted fails when the queue does not exist
    Given the queue does not exist
    When a queue is deleted
    Then the operation is rejected

  @guard @negative @delete_queue @lifecycle
  Scenario: a queue is deleted fails when the queue is not "ACTIVE"
    Given the queue exists
    And the queue is not "ACTIVE"
    When a queue is deleted
    Then the operation is rejected
