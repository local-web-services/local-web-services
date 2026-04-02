@rdsevents @generated
Feature: RdsEvents - The "Rds" "Instance" Stops But The State Change Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given the "rds" "DB instance" was "AVAILABLE"
    And the "eventbridge" "bus" was "DELETED"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the "rds" "DB instance" will be "STOPPING" but no event will be delivered
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted fails when the "rds" "DB instance" was not "AVAILABLE"
    Given the "rds" "DB instance" was not "AVAILABLE"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted fails when the "eventbridge" "bus" was not "DELETED"
    Given the "rds" "DB instance" was "AVAILABLE"
    And the "eventbridge" "bus" was not "DELETED"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected
