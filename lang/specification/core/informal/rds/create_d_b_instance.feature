@rds @generated
Feature: Rds - A Database Instance Is Created

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a database instance is created
    Given the database instance does not already exist
    When a database instance is created
    Then the instance is in "CREATING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @create_d_b_instance
  Scenario: a database instance is created fails when the database instance already exists
    Given the database instance already exists
    When a database instance is created
    Then the operation is rejected
