@eventssqs @generated
Feature: EventsSqs - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the event bus does not already exist
    When an EventBridge event bus is created
    Then the event bus is "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the event bus already exists
    Given the event bus already exists
    When an EventBridge event bus is created
    Then the operation is rejected
