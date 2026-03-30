@rds @generated
Feature: Rds - A Database Instance Is Deleted Without A Final Snapshot

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_instance_skip_snapshot
  Scenario: a database instance is deleted without a final snapshot
    Given the database instance exists
    And the instance is "AVAILABLE" or "FAILED"
    When a database instance is deleted without a final snapshot
    Then the instance is in "DELETING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @delete_d_b_instance_skip_snapshot
  Scenario: a database instance is deleted without a final snapshot fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance is deleted without a final snapshot
    Then the operation is rejected

  @guard @negative @delete_d_b_instance_skip_snapshot @lifecycle
  Scenario: a database instance is deleted without a final snapshot fails when the instance is neither "AVAILABLE" nor "FAILED"
    Given the database instance exists
    And the instance is neither "AVAILABLE" nor "FAILED"
    When a database instance is deleted without a final snapshot
    Then the operation is rejected
