@rds @generated
Feature: Rds - A "Rds" "Snapshot" Is Deleted

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_snapshot
  Scenario: a "rds" "snapshot" is deleted
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "AVAILABLE"
    When a "rds" "snapshot" is deleted
    Then the "rds" "snapshot" will be in "DELETING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @delete_d_b_snapshot
  Scenario: a "rds" "snapshot" is deleted fails when the "rds" "snapshot" did not exist
    Given the "rds" "snapshot" did not exist
    When a "rds" "snapshot" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_snapshot @lifecycle
  Scenario: a "rds" "snapshot" is deleted fails when the "rds" "snapshot" was not "AVAILABLE"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was not "AVAILABLE"
    When a "rds" "snapshot" is deleted
    Then the operation is rejected
