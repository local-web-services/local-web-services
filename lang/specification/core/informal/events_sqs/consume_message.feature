@eventssqs @generated
Feature: EventsSqs - A Message Is Consumed From The "Sqs" "Queue"

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a message is consumed from the "sqs" "queue"
    Given an "AVAILABLE" "sqs" "message" existed in the "sqs" "queue"
    When a message is consumed from the "sqs" "queue"
    Then the "sqs" "message" will be "DELETED"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @consume_message @lifecycle
  Scenario: a message is consumed from the "sqs" "queue" fails when no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue"
    Given no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue"
    When a message is consumed from the "sqs" "queue"
    Then the operation is rejected
