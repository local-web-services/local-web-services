@rds @generated
Feature: Rds - A Database Snapshot Is Deleted

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_snapshot
  Scenario: a database snapshot is deleted
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    When a database snapshot is deleted
    Then the snapshot is in "DELETING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @delete_d_b_snapshot
  Scenario: a database snapshot is deleted fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database snapshot is deleted
    Then the operation is rejected

  @standard @negative @delete_d_b_snapshot @lifecycle @internal
  Scenario: a database snapshot is deleted fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a database snapshot is deleted
    Then the operation is rejected
