@sqs @generated
Feature: Sqs - "Sqs" "Message" Visibility Timeout Is Changed

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @change_message_visibility
  Scenario: "sqs" "message" visibility timeout is changed
    Given the "sqs" "message" existed
    And the "sqs" "message" was "IN_FLIGHT"
    When "sqs" "message" visibility timeout is changed
    Then the "sqs" "message" visibility will be updated
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @guard @negative @change_message_visibility
  Scenario: "sqs" "message" visibility timeout is changed fails when the "sqs" "message" did not exist
    Given the "sqs" "message" did not exist
    When "sqs" "message" visibility timeout is changed
    Then the operation is rejected

  @guard @negative @change_message_visibility
  Scenario: "sqs" "message" visibility timeout is changed fails when the "sqs" "message" was not "IN_FLIGHT"
    Given the "sqs" "message" existed
    And the "sqs" "message" was not "IN_FLIGHT"
    When "sqs" "message" visibility timeout is changed
    Then the operation is rejected
