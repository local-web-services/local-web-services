@rds @generated
Feature: Rds - A "Rds" "Snapshot" Finishes Creating

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_create_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" finishes creating
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "CREATING"
    And the "rds" "instance" existed
    And the "rds" "instance" was "BACKING_UP"
    When a "rds" "snapshot" finishes creating
    Then the "rds" "snapshot" will be "AVAILABLE" and the "rds" "instance" returns to "AVAILABLE" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" finishes creating fails when the "rds" "snapshot" did not exist
    Given the "rds" "snapshot" did not exist
    When a "rds" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" finishes creating fails when the "rds" "snapshot" was not "CREATING"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was not "CREATING"
    When a "rds" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" finishes creating fails when the "rds" "instance" did not exist
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "CREATING"
    And the "rds" "instance" did not exist
    When a "rds" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a "rds" "snapshot" finishes creating fails when the "rds" "instance" was not "BACKING_UP"
    Given the "rds" "snapshot" existed
    And the "rds" "snapshot" was "CREATING"
    And the "rds" "instance" existed
    And the "rds" "instance" was not "BACKING_UP"
    When a "rds" "snapshot" finishes creating
    Then the operation is rejected
