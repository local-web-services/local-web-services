@sqs @generated
Feature: Sqs - A "Sqs" "Message" Is Received From The "Sqs" "Queue"

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @receive_message
  Scenario: a "sqs" "message" is received from the "sqs" "queue"
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "message"'s "sqs" "queue" was "ACTIVE"
    When a "sqs" "message" is received from the "sqs" "queue"
    Then the "sqs" "message" will be "IN_FLIGHT"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @guard @negative @receive_message
  Scenario: a "sqs" "message" is received from the "sqs" "queue" fails when the "sqs" "message" did not exist
    Given the "sqs" "message" did not exist
    When a "sqs" "message" is received from the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @receive_message
  Scenario: a "sqs" "message" is received from the "sqs" "queue" fails when the "sqs" "message" was not "AVAILABLE"
    Given the "sqs" "message" existed
    And the "sqs" "message" was not "AVAILABLE"
    When a "sqs" "message" is received from the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @receive_message
  Scenario: a "sqs" "message" is received from the "sqs" "queue" fails when the "sqs" "message"'s "sqs" "queue" did not exist
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" did not exist
    When a "sqs" "message" is received from the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @receive_message @lifecycle
  Scenario: a "sqs" "message" is received from the "sqs" "queue" fails when the "sqs" "message"'s "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "message" existed
    And the "sqs" "message" was "AVAILABLE"
    And the "sqs" "message"'s "sqs" "queue" existed
    And the "sqs" "message"'s "sqs" "queue" was not "ACTIVE"
    When a "sqs" "message" is received from the "sqs" "queue"
    Then the operation is rejected
