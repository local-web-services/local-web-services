@ssmevents @generated
Feature: SsmEvents - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: ssm_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingParameter, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the bus did not already exist
    When an EventBridge event bus is created
    Then the bus will be "ACTIVE"
    And every "DELIVERED" event references a parameter that exists (in any state)
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the bus already existed
    Given the bus already existed
    When an EventBridge event bus is created
    Then the operation is rejected
