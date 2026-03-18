@rdsevents @generated
Feature: RdsEvents - An Rds Db Instance Is Created And Becomes Available

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given the "DB" instance does not already exist
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then the "DB" instance is "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @create_d_b_instance
  Scenario: an "RDS" "DB" instance is created and becomes "AVAILABLE" fails when the "DB" instance already exists
    Given the "DB" instance already exists
    When an "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then the operation is rejected
