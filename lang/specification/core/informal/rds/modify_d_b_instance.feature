@rds @generated
Feature: Rds - A "Rds" "Instance" Configuration Is Modified

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_instance
  Scenario: a "rds" "instance" configuration is modified
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    When a "rds" "instance" configuration is modified
    Then the "rds" "instance" will be in "MODIFYING" state
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @modify_d_b_instance
  Scenario: a "rds" "instance" configuration is modified fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance @lifecycle
  Scenario: a "rds" "instance" configuration is modified fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a "rds" "instance" configuration is modified
    Then the operation is rejected
