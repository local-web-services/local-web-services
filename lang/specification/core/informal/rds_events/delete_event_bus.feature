@rdsevents @generated
Feature: RdsEvents - The Eventbridge Event Bus Is Deleted

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @delete_event_bus
  Scenario: the EventBridge event bus is deleted
    Given the bus existed
    And the bus was "ACTIVE"
    When the EventBridge event bus is deleted
    Then the bus will be deleted and "RDS" event delivery will fail
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @delete_event_bus
  Scenario: the EventBridge event bus is deleted fails when the bus did not exist
    Given the bus did not exist
    When the EventBridge event bus is deleted
    Then the operation is rejected

  @guard @negative @delete_event_bus @lifecycle
  Scenario: the EventBridge event bus is deleted fails when the bus is already "DELETED"
    Given the bus existed
    And the bus is already "DELETED"
    When the EventBridge event bus is deleted
    Then the operation is rejected
