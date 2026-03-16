@neptuneevents @generated
Feature: NeptuneEvents - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: neptune_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingCluster, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the bus does not already exist
    When an EventBridge event bus is created
    Then the bus is "ACTIVE"
    And every "DELIVERED" event references a cluster that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the bus already exists
    Given the bus already exists
    When an EventBridge event bus is created
    Then the operation is rejected
