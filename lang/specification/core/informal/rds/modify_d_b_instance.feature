@rds @generated
Feature: Rds - A Database Instance Configuration Is Modified

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_instance
  Scenario: a database instance configuration is modified
    Given the database instance exists
    And the instance is "AVAILABLE"
    When a database instance configuration is modified
    Then the instance is in "MODIFYING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @modify_d_b_instance
  Scenario: a database instance configuration is modified fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance configuration is modified
    Then the operation is rejected

  @standard @negative @modify_d_b_instance @lifecycle @internal
  Scenario: a database instance configuration is modified fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When a database instance configuration is modified
    Then the operation is rejected
