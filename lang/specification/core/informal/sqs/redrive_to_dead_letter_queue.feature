@sqs @generated
Feature: Sqs - A Message Exceeding Its Receive Count Is Moved To The Dead-Letter Queue

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the queue has a maximum receive count configured
    And the message has exceeded the maximum receive count
    And the dead-letter queue exists
    And the dead-letter queue is "ACTIVE"
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the message is "AVAILABLE" in the dead-letter queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the message does not exist
    Given the message does not exist
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the message is not "AVAILABLE"
    Given the message exists
    And the message is not "AVAILABLE"
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the message's queue does not exist
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue does not exist
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the queue does not have a maximum receive count configured
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the queue does not have a maximum receive count configured
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the message has not exceeded the maximum receive count
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the queue has a maximum receive count configured
    And the message has not exceeded the maximum receive count
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the dead-letter queue does not exist
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the queue has a maximum receive count configured
    And the message has exceeded the maximum receive count
    And the dead-letter queue does not exist
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected

  @standard @negative @redrive_to_dead_letter_queue @internal
  Scenario: a message exceeding its receive count is moved to the dead-letter queue fails when the dead-letter queue is not "ACTIVE"
    Given the message exists
    And the message is "AVAILABLE"
    And the message's queue exists
    And the queue has a maximum receive count configured
    And the message has exceeded the maximum receive count
    And the dead-letter queue exists
    And the dead-letter queue is not "ACTIVE"
    When a message exceeding its receive count is moved to the dead-letter queue
    Then the operation is rejected
