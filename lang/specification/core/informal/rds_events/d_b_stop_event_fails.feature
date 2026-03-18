@rdsevents @generated
Feature: RdsEvents - The Rds Instance Stops But The State Change Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_event_fails @internal
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Given the "DB" instance is "AVAILABLE"
    And the bus is "DELETED"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then the "DB" instance is "STOPPING" but no event is delivered
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @d_b_stop_event_fails @internal
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted fails when the "DB" instance is not "AVAILABLE"
    Given the "DB" instance is not "AVAILABLE"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @d_b_stop_event_fails @internal
  Scenario: the "RDS" instance stops but the state change event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the "DB" instance is "AVAILABLE"
    And the bus is not "DELETED"
    When the "RDS" instance stops but the state change event delivery fails because the bus is deleted
    Then the operation is rejected
