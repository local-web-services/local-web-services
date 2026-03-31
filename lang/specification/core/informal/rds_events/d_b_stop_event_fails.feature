@rdsevents @generated
Feature: RdsEvents - The "Rds" "Instance" Stops But The State Change Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Given the "DB" instance was "AVAILABLE"
    And the bus was "DELETED"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the "DB" instance will be "STOPPING" but no event will be delivered
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted fails when the "DB" instance was not "AVAILABLE"
    Given the "DB" instance was not "AVAILABLE"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @d_b_stop_event_fails @internal
  Scenario: the "rds" "instance" stops but the state change event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given the "DB" instance was "AVAILABLE"
    And the bus was not "DELETED"
    When the "rds" "instance" stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected
