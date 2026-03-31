@sqs @generated
Feature: Sqs - All "Sqs" "Message"S In A "Sqs" "Queue" Are Purged

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @purge_queue
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    Then all messages in the "sqs" "queue" will be "DELETED"
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @purge_queue
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When all "sqs" "message"s in a "sqs" "queue" are purged
    Then the operation is rejected

  @guard @negative @purge_queue @lifecycle
  Scenario: all "sqs" "message"s in a "sqs" "queue" are purged fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When all "sqs" "message"s in a "sqs" "queue" are purged
    Then the operation is rejected
