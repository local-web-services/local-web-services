@sqs @generated
Feature: Sqs - A Message Is Sent To The Queue

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @send_message
  Scenario: a message is sent to the queue
    Given the queue exists
    And the queue is "ACTIVE"
    And the message slot is available
    When a message is sent to the queue
    Then the message is "AVAILABLE" for delivery
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @standard @negative @send_message
  Scenario: a message is sent to the queue fails when the queue does not exist
    Given the queue does not exist
    When a message is sent to the queue
    Then the operation is rejected

  @standard @negative @send_message @lifecycle
  Scenario: a message is sent to the queue fails when the queue is not "ACTIVE"
    Given the queue exists
    And the queue is not "ACTIVE"
    When a message is sent to the queue
    Then the operation is rejected

  @standard @negative @send_message @capacity
  Scenario: a message is sent to the queue fails when the message slot is not available
    Given the queue exists
    And the queue is "ACTIVE"
    And the message slot is not available
    When a message is sent to the queue
    Then the operation is rejected
