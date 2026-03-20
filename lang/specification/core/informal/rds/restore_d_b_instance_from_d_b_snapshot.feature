@rds @generated
Feature: Rds - A Database Instance Is Restored From A Snapshot

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @restore_d_b_instance_from_d_b_snapshot
  Scenario: a database instance is restored from a snapshot
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target instance slot is available
    When a database instance is restored from a snapshot
    Then the restored instance is in "RESTORING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @restore_d_b_instance_from_d_b_snapshot
  Scenario: a database instance is restored from a snapshot fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database instance is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_d_b_instance_from_d_b_snapshot @lifecycle
  Scenario: a database instance is restored from a snapshot fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a database instance is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_d_b_instance_from_d_b_snapshot
  Scenario: a database instance is restored from a snapshot fails when the target instance slot is not available
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target instance slot is not available
    When a database instance is restored from a snapshot
    Then the operation is rejected
