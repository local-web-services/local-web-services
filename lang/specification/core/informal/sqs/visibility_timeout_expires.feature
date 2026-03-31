@sqs @generated
Feature: Sqs - A "Sqs" "Message" Visibility Timeout Expires

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @visibility_timeout_expires @internal
  Scenario: a "sqs" "message" visibility timeout expires
    Given the "sqs" "message" existed
    And the "sqs" "message" was "IN_FLIGHT"
    When a "sqs" "message" visibility timeout expires
    Then the "sqs" "message" becomes "AVAILABLE" again
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @visibility_timeout_expires @internal
  Scenario: a "sqs" "message" visibility timeout expires fails when the "sqs" "message" did not exist
    Given the "sqs" "message" did not exist
    When a "sqs" "message" visibility timeout expires
    Then the operation is rejected

  @guard @negative @visibility_timeout_expires @internal
  Scenario: a "sqs" "message" visibility timeout expires fails when the "sqs" "message" was not "IN_FLIGHT"
    Given the "sqs" "message" existed
    And the "sqs" "message" was not "IN_FLIGHT"
    When a "sqs" "message" visibility timeout expires
    Then the operation is rejected
