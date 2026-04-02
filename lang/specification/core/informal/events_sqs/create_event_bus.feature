@eventssqs @generated
Feature: EventsSqs - An "Eventbridge" "Bus" Is Created

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an "eventbridge" "bus" is created
    Given the "eventbridge" "bus" did not already exist
    When an "eventbridge" "bus" is created
    Then the "eventbridge" "bus" will be "ACTIVE"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @create_event_bus
  Scenario: an "eventbridge" "bus" is created fails when the "eventbridge" "bus" already existed
    Given the "eventbridge" "bus" already existed
    When an "eventbridge" "bus" is created
    Then the operation is rejected
