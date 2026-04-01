@rds @generated
Feature: Rds - A "Rds" "Instance" Finishes Creating

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @activate_d_b_instance @internal
  Scenario: a "rds" "instance" finishes creating
    Given the "rds" "instance" existed
    And the "rds" "instance" was "CREATING"
    When a "rds" "instance" finishes creating
    Then the "rds" "instance" will be "AVAILABLE" or "FAILED"
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @activate_d_b_instance @internal
  Scenario: a "rds" "instance" finishes creating fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @activate_d_b_instance @internal
  Scenario: a "rds" "instance" finishes creating fails when the "rds" "instance" was not "CREATING"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "CREATING"
    When a "rds" "instance" finishes creating
    Then the operation is rejected
