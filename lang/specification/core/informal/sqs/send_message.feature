@sqs @generated
Feature: Sqs - A "Sqs" "Message" Is Sent To The "Sqs" "Queue"

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @send_message
  Scenario: a "sqs" "message" is sent to the "sqs" "queue"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the message slot is available
    When a "sqs" "message" is sent to the "sqs" "queue"
    Then the "sqs" "message" will be "AVAILABLE" for delivery
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @send_message
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When a "sqs" "message" is sent to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @send_message @lifecycle
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "sqs" "message" is sent to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @send_message @capacity
  Scenario: a "sqs" "message" is sent to the "sqs" "queue" fails when the message slot is not available
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the message slot is not available
    When a "sqs" "message" is sent to the "sqs" "queue"
    Then the operation is rejected
