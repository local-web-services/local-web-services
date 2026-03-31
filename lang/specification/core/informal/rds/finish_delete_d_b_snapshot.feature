@rds @generated
Feature: Rds - A "Rds" "Snapshot" Deletion Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" deletion completes
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "DELETING"
    When a "rds" "snapshot" deletion completes
    Then the "rds" "snapshot" will be "DELETED"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_delete_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" deletion completes fails when the "rds" "snapshot" did not exist
    Given the "rds" "snapshot" did not exist
    When a "rds" "snapshot" deletion completes
    Then the operation is rejected

  @guard @negative @finish_delete_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" deletion completes fails when the "rds" "snapshot" was not "DELETING"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was not "DELETING"
    When a "rds" "snapshot" deletion completes
    Then the operation is rejected
