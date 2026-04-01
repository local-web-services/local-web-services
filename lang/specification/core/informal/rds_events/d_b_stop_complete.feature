@rdsevents @generated
Feature: RdsEvents - The "Rds" "Db Instance" Finishes Stopping

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @d_b_stop_complete @internal
  Scenario: the "rds" "DB instance" finishes stopping
    Given the "rds" "DB instance" was "STOPPING"
    When the "rds" "DB instance" finishes stopping
    Then the "rds" "DB instance" will be "STOPPED"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @d_b_stop_complete @internal
  Scenario: the "rds" "DB instance" finishes stopping fails when the "rds" "DB instance" was not "STOPPING"
    Given the "rds" "DB instance" was not "STOPPING"
    When the "rds" "DB instance" finishes stopping
    Then the operation is rejected
