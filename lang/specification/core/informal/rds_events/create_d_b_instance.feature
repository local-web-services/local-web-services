@rdsevents @generated
Feature: RdsEvents - A Rds Db Instance Is Created And Becomes Available

  # Generated from FizzBee spec: rds_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingDB, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a "RDS" "DB" instance is created and becomes "AVAILABLE"
    Given the "DB" instance did not already exist
    When a "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then the "DB" instance will be "AVAILABLE"
    And every "DELIVERED" event references a "DB" instance that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_d_b_instance
  Scenario: a "RDS" "DB" instance is created and becomes "AVAILABLE" fails when the "DB" instance already existed
    Given the "DB" instance already existed
    When a "RDS" "DB" instance is created and becomes "AVAILABLE"
    Then the operation is rejected
