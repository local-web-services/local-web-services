@sqs @generated
Feature: Sqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the "sqs" "queue" did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every non-deleted "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"
    And every "sqs" "message" has a non-negative receive count

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the "sqs" "queue" already existed
    Given the "sqs" "queue" already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
