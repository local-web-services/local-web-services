@rds @generated
Feature: Rds - A "Rds" "Instance" Is Deleted Without A Final "Rds" "Snapshot"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_instance_skip_snapshot
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE" or "FAILED"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    Then the "rds" "instance" will be in "DELETING" state
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @delete_d_b_instance_skip_snapshot
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    Then the operation is rejected

  @guard @negative @delete_d_b_instance_skip_snapshot @lifecycle
  Scenario: a "rds" "instance" is deleted without a final "rds" "snapshot" fails when the "rds" "instance" is neither "AVAILABLE" nor "FAILED"
    Given the "rds" "instance" existed
    And the "rds" "instance" is neither "AVAILABLE" nor "FAILED"
    When a "rds" "instance" is deleted without a final "rds" "snapshot"
    Then the operation is rejected
