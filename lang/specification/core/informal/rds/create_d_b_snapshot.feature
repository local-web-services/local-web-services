@rds @generated
Feature: Rds - A "Rds" "Snapshot" Is Created From A "Rds" "Instance"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_snapshot
  Scenario: a "rds" "snapshot" is created from a "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And a "rds" "snapshot" slot is available
    When a "rds" "snapshot" is created from a "rds" "instance"
    Then the "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @create_d_b_snapshot
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "snapshot" is created from a "rds" "instance"
    Then the operation is rejected

  @guard @negative @create_d_b_snapshot @lifecycle
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a "rds" "snapshot" is created from a "rds" "instance"
    Then the operation is rejected

  @guard @negative @create_d_b_snapshot
  Scenario: a "rds" "snapshot" is created from a "rds" "instance" fails when no "rds" "snapshot" slot is available
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And no "rds" "snapshot" slot is available
    When a "rds" "snapshot" is created from a "rds" "instance"
    Then the operation is rejected
