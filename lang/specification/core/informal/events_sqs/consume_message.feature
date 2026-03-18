@eventssqs @generated
Feature: EventsSqs - A Message Is Consumed From The Sqs Queue

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @consume_message
  Scenario: a message is consumed from the "SQS" queue
    Given an "AVAILABLE" message exists in the queue
    When a message is consumed from the "SQS" queue
    Then the message is "DELETED"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @consume_message @lifecycle @internal
  Scenario: a message is consumed from the "SQS" queue fails when no "AVAILABLE" message exists in the queue
    Given no "AVAILABLE" message exists in the queue
    When a message is consumed from the "SQS" queue
    Then the operation is rejected
