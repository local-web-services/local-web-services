@rds @generated
Feature: Rds - A Database Instance Restore From Snapshot Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_restore_d_b_instance @internal
  Scenario: a database instance restore from snapshot completes
    Given the database instance exists
    And the instance is "RESTORING"
    When a database instance restore from snapshot completes
    Then the instance is "AVAILABLE"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_restore_d_b_instance @internal
  Scenario: a database instance restore from snapshot completes fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance restore from snapshot completes
    Then the operation is rejected

  @guard @negative @finish_restore_d_b_instance @internal
  Scenario: a database instance restore from snapshot completes fails when the instance is not "RESTORING"
    Given the database instance exists
    And the instance is not "RESTORING"
    When a database instance restore from snapshot completes
    Then the operation is rejected
