@sqs @generated
Feature: Sqs - Message Visibility Timeout Is Changed

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @change_message_visibility
  Scenario: message visibility timeout is changed
    Given the message exists
    And the message is "IN_FLIGHT"
    When message visibility timeout is changed
    Then the message visibility is updated
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @change_message_visibility
  Scenario: message visibility timeout is changed fails when the message does not exist
    Given the message does not exist
    When message visibility timeout is changed
    Then the operation is rejected

  @guard @negative @change_message_visibility
  Scenario: message visibility timeout is changed fails when the message is not "IN_FLIGHT"
    Given the message exists
    And the message is not "IN_FLIGHT"
    When message visibility timeout is changed
    Then the operation is rejected
