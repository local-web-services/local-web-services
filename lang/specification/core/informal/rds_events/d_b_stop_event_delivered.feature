@rdsevents @generated
Feature: RdsEvents - The "Rds" "Instance" Stops And Delivers The State Change Event To The Eventbridge Bus

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Given the "rds" "DB instance" was "AVAILABLE"
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the "rds" "DB instance" will be "STOPPING" and the "eventbridge" "event" will be "DELIVERED"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when the "rds" "DB instance" was not "AVAILABLE"
    Given the "rds" "DB instance" was not "AVAILABLE"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when the "eventbridge" "bus" was "DELETED"
    Given the "rds" "DB instance" was "AVAILABLE"
    And the "eventbridge" "bus" was "DELETED"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @d_b_stop_event_delivered @internal
  Scenario: the "rds" "instance" stops and delivers the state change event to the EventBridge bus fails when no "eventbridge" "event" "slot" was "available"
    Given the "rds" "DB instance" was "AVAILABLE"
    And the "eventbridge" "bus" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When the "rds" "instance" stops and delivers the state change event to the EventBridge bus
    Then the operation is rejected
