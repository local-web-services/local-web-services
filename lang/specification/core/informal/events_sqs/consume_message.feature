@eventssqs @generated
Feature: EventsSqs - A Message Is Consumed From The "Sqs" "Queue"

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a message is consumed from the "sqs" "queue"
    Given an "AVAILABLE" message existed in the queue
    When a message is consumed from the "sqs" "queue"
    Then the message will be deleted
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @consume_message @lifecycle
  Scenario: a message is consumed from the "sqs" "queue" fails when no "AVAILABLE" message existed in the queue
    Given no "AVAILABLE" message existed in the queue
    When a message is consumed from the "sqs" "queue"
    Then the operation is rejected
