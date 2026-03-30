@sqs @generated
Feature: Sqs - An In-Flight Message Is Deleted

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @delete_message
  Scenario: an in-flight message is deleted
    Given the message exists
    And the message is "IN_FLIGHT"
    When an in-flight message is deleted
    Then the message is removed from the queue
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @delete_message
  Scenario: an in-flight message is deleted fails when the message does not exist
    Given the message does not exist
    When an in-flight message is deleted
    Then the operation is rejected

  @guard @negative @delete_message
  Scenario: an in-flight message is deleted fails when the message is not "IN_FLIGHT"
    Given the message exists
    And the message is not "IN_FLIGHT"
    When an in-flight message is deleted
    Then the operation is rejected
