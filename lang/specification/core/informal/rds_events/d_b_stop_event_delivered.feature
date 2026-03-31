@rdsevents @generated
Feature: RdsEvents - The "Rds" "Instance" Stops And Delivers The State Change Event To The Eventbridge Bus

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given the "DB" instance was "AVAILABLE"
    And the bus was "ACTIVE"
    And an event slot is available
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the "DB" instance will be "STOPPING" and the event will be "DELIVERED"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when the "DB" instance was not "AVAILABLE"
    Given the "DB" instance was not "AVAILABLE"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when the bus was "DELETED"
    Given the "DB" instance was "AVAILABLE"
    And the bus was "DELETED"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when no event slot is available
    Given the "DB" instance was "AVAILABLE"
    And the bus was "ACTIVE"
    And no event slot is available
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected
