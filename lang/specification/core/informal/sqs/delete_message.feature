@sqs @generated
Feature: Sqs - An In-Flight "Sqs" "Message" Is Deleted

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @delete_message
  Scenario: an in-flight "sqs" "message" is deleted
    Given the "sqs" "message" existed
    And the "sqs" "message" was "IN_FLIGHT"
    When an in-flight "sqs" "message" is deleted
    Then the "sqs" "message" will be removed from the "sqs" "queue"
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @delete_message
  Scenario: an in-flight "sqs" "message" is deleted fails when the "sqs" "message" did not exist
    Given the "sqs" "message" did not exist
    When an in-flight "sqs" "message" is deleted
    Then the operation is rejected

  @guard @negative @delete_message
  Scenario: an in-flight "sqs" "message" is deleted fails when the "sqs" "message" was not "IN_FLIGHT"
    Given the "sqs" "message" existed
    And the "sqs" "message" was not "IN_FLIGHT"
    When an in-flight "sqs" "message" is deleted
    Then the operation is rejected
