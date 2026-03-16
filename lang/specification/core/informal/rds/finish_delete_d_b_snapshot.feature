@rds @generated
Feature: Rds - A Database Snapshot Deletion Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_d_b_snapshot @internal
  Scenario: a database snapshot deletion completes
    Given the snapshot exists
    And the snapshot is "DELETING"
    When a database snapshot deletion completes
    Then the snapshot is "DELETED"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @finish_delete_d_b_snapshot @internal
  Scenario: a database snapshot deletion completes fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database snapshot deletion completes
    Then the operation is rejected

  @standard @negative @finish_delete_d_b_snapshot @internal
  Scenario: a database snapshot deletion completes fails when the snapshot is not "DELETING"
    Given the snapshot exists
    And the snapshot is not "DELETING"
    When a database snapshot deletion completes
    Then the operation is rejected
