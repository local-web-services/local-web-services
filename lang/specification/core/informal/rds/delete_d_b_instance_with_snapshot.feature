@rds @generated
Feature: Rds - A "Rds" "Instance" Is Deleted With A Final "Rds" "Snapshot"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_instance_with_snapshot
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And a "rds" "snapshot" slot is available
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    Then the "rds" "instance" will be in "DELETING" state and a "rds" "snapshot" will be "CREATING"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @delete_d_b_instance_with_snapshot
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    Then the operation is rejected

  @guard @negative @delete_d_b_instance_with_snapshot @lifecycle
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    Then the operation is rejected

  @guard @negative @delete_d_b_instance_with_snapshot
  Scenario: a "rds" "instance" is deleted with a final "rds" "snapshot" fails when no "rds" "snapshot" slot is available
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And no "rds" "snapshot" slot is available
    When a "rds" "instance" is deleted with a final "rds" "snapshot"
    Then the operation is rejected
