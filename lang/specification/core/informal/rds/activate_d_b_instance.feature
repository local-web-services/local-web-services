@rds @generated
Feature: Rds - A Database Instance Finishes Creating

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @activate_d_b_instance @internal
  Scenario: a database instance finishes creating
    Given the database instance exists
    And the instance is "CREATING"
    When a database instance finishes creating
    Then the instance is "AVAILABLE" or "FAILED"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @activate_d_b_instance @internal
  Scenario: a database instance finishes creating fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance finishes creating
    Then the operation is rejected

  @guard @negative @activate_d_b_instance @internal
  Scenario: a database instance finishes creating fails when the instance is not "CREATING"
    Given the database instance exists
    And the instance is not "CREATING"
    When a database instance finishes creating
    Then the operation is rejected
