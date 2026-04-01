@rds @generated
Feature: Rds - A "Rds" "Instance" Restore From "Rds" "Snapshot" Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_restore_d_b_instance @internal
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes
    Given the "rds" "instance" existed
    And the "rds" "instance" was "RESTORING"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    Then the "rds" "instance" will be "AVAILABLE"
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @finish_restore_d_b_instance @internal
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" restore from "rds" "snapshot" completes
    Then the operation is rejected

  @guard @negative @finish_restore_d_b_instance @internal
  Scenario: a "rds" "instance" restore from "rds" "snapshot" completes fails when the "rds" "instance" was not "RESTORING"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "RESTORING"
    When a "rds" "instance" restore from "rds" "snapshot" completes
    Then the operation is rejected
