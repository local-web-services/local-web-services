@rdsevents @generated
Feature: RdsEvents - The Db Instance Finishes Stopping

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_complete @internal
  Scenario: the "DB" instance finishes stopping
    Given the "DB" instance was "STOPPING"
    When the "DB" instance finishes stopping
    Then the "DB" instance will be "STOPPED"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @d_b_stop_complete @internal
  Scenario: the "DB" instance finishes stopping fails when the "DB" instance was not "STOPPING"
    Given the "DB" instance was not "STOPPING"
    When the "DB" instance finishes stopping
    Then the operation is rejected
