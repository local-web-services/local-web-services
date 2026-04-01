@rds @generated
Feature: Rds - A "Rds" "Instance" Is Restored From A "Rds" "Snapshot"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @restore_d_b_instance_from_d_b_snapshot
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "AVAILABLE"
    And the target "rds" "instance" slot is available
    When a "rds" "instance" is restored from a "rds" "snapshot"
    Then the restored "rds" "instance" will be in "RESTORING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @restore_d_b_instance_from_d_b_snapshot
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" fails when the "rds" "snapshot" did not exist
    Given the "rds" "snapshot" did not exist
    When a "rds" "instance" is restored from a "rds" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_d_b_instance_from_d_b_snapshot @lifecycle
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" fails when the "rds" "snapshot" was not "AVAILABLE"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was not "AVAILABLE"
    When a "rds" "instance" is restored from a "rds" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_d_b_instance_from_d_b_snapshot
  Scenario: a "rds" "instance" is restored from a "rds" "snapshot" fails when the target "rds" "instance" slot is not available
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "AVAILABLE"
    And the target "rds" "instance" slot is not available
    When a "rds" "instance" is restored from a "rds" "snapshot"
    Then the operation is rejected
