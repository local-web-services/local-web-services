@sqs @generated
Feature: Sqs - A "Sqs" "Queue" Is Deleted

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @delete_queue
  Scenario: a "sqs" "queue" is deleted
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When a "sqs" "queue" is deleted
    Then the "sqs" "queue" will be "DELETED" and its messages will be removed
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @delete_queue
  Scenario: a "sqs" "queue" is deleted fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When a "sqs" "queue" is deleted
    Then the operation is rejected

  @guard @negative @delete_queue @lifecycle
  Scenario: a "sqs" "queue" is deleted fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "sqs" "queue" is deleted
    Then the operation is rejected
