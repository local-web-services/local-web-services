@sqs @generated
Feature: Sqs - A Message Visibility Timeout Expires

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @visibility_timeout_expires @internal
  Scenario: a message visibility timeout expires
    Given the message exists
    And the message is "IN_FLIGHT"
    When a message visibility timeout expires
    Then the message becomes "AVAILABLE" again
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @visibility_timeout_expires @internal
  Scenario: a message visibility timeout expires fails when the message does not exist
    Given the message does not exist
    When a message visibility timeout expires
    Then the operation is rejected

  @guard @negative @visibility_timeout_expires @internal
  Scenario: a message visibility timeout expires fails when the message is not "IN_FLIGHT"
    Given the message exists
    And the message is not "IN_FLIGHT"
    When a message visibility timeout expires
    Then the operation is rejected
