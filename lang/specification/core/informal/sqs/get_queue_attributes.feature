@sqs @generated
Feature: Sqs - "Sqs" "Queue" Attributes Are Retrieved

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @get_queue_attributes
  Scenario: "sqs" "queue" attributes are retrieved
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When "sqs" "queue" attributes are retrieved
    Then the "sqs" "queue" attributes will be returned
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @get_queue_attributes
  Scenario: "sqs" "queue" attributes are retrieved fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When "sqs" "queue" attributes are retrieved
    Then the operation is rejected

  @guard @negative @get_queue_attributes @lifecycle
  Scenario: "sqs" "queue" attributes are retrieved fails when the "sqs" "queue" was not "ACTIVE"
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When "sqs" "queue" attributes are retrieved
    Then the operation is rejected
