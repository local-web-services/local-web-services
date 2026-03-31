@eventssqs @generated
Feature: EventsSqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the queue did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the queue already existed
    Given the queue already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
