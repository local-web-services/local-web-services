@rdsevents @generated
Feature: RdsEvents - An "Rds" "Db Instance" Is Created And Becomes "Available"

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE"
    Given the "rds" "instance" did not already exist
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    Then the "rds" "DB instance" will be "AVAILABLE"
    And every "DELIVERED" "eventbridge" "event" references an "rds" "DB instance" that exists
    And every "DELIVERED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @guard @negative @create_d_b_instance
  Scenario: an "rds" "DB instance" is created and becomes "AVAILABLE" fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When an "rds" "DB instance" is created and becomes "AVAILABLE"
    Then the operation is rejected
