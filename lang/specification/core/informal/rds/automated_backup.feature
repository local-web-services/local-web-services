@rds @generated
Feature: Rds - An Automated Backup Runs On An Available "Rds" "Instance"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @automated_backup @internal
  Scenario: an automated backup runs on an available "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And a "rds" "snapshot" slot is available
    When an automated backup runs on an available "rds" "instance"
    Then a "rds" "snapshot" will be "CREATING" and the "rds" "instance" will be in "BACKING_UP" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When an automated backup runs on an available "rds" "instance"
    Then the operation is rejected

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When an automated backup runs on an available "rds" "instance"
    Then the operation is rejected

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available "rds" "instance" fails when no "rds" "snapshot" slot is available
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And no "rds" "snapshot" slot is available
    When an automated backup runs on an available "rds" "instance"
    Then the operation is rejected
