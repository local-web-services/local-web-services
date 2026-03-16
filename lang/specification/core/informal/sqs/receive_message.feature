@sqs @generated
Feature: Sqs - A Message Is Received From The Queue

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @receive_message
  Scenario: a message is received from the queue
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the message's queue is "ACTIVE"
    When a message is received from the queue
    Then the message is "IN_FLIGHT"
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @standard @negative @receive_message
  Scenario: a message is received from the queue fails when the message does not exist
    Given the message does not exist
    When a message is received from the queue
    Then the operation is rejected

  @standard @negative @receive_message
  Scenario: a message is received from the queue fails when the message is not "AVAILABLE"
    Given the message exists
    And the message is not "AVAILABLE"
    When a message is received from the queue
    Then the operation is rejected

  @standard @negative @receive_message
  Scenario: a message is received from the queue fails when the message's queue does not exist
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue does not exist
    When a message is received from the queue
    Then the operation is rejected

  @standard @negative @receive_message @lifecycle
  Scenario: a message is received from the queue fails when the message's queue is not "ACTIVE"
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the message's queue is not "ACTIVE"
    When a message is received from the queue
    Then the operation is rejected
