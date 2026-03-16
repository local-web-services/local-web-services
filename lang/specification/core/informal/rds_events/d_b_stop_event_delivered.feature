@rdsevents @generated
Feature: RdsEvents - The Rds Instance Stops And Delivers The State Change Event To The Eventbridge Bus

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_delivered @internal
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Given the "DB" instance is "AVAILABLE"
    And the bus is "ACTIVE"
    And an event slot is available
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then the "DB" instance is "STOPPING" and the event is "DELIVERED"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @d_b_stop_event_delivered @internal
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus fails when the "DB" instance is not "AVAILABLE"
    Given the "DB" instance is not "AVAILABLE"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @d_b_stop_event_delivered @internal
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus fails when the bus is "DELETED"
    Given the "DB" instance is "AVAILABLE"
    And the bus is "DELETED"
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @d_b_stop_event_delivered @internal
  Scenario: the "RDS" instance stops and delivers the state change event to the EventBridge bus fails when no event slot is available
    Given the "DB" instance is "AVAILABLE"
    And the bus is "ACTIVE"
    And no event slot is available
    When the "RDS" instance stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected
