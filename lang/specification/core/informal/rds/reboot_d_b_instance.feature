@rds @generated
Feature: Rds - A "Rds" "Instance" Is Rebooted

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @reboot_d_b_instance
  Scenario: a "rds" "instance" is rebooted
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    When a "rds" "instance" is rebooted
    Then the "rds" "instance" will be in "REBOOTING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @reboot_d_b_instance
  Scenario: a "rds" "instance" is rebooted fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" is rebooted
    Then the operation is rejected

  @guard @negative @reboot_d_b_instance @lifecycle
  Scenario: a "rds" "instance" is rebooted fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a "rds" "instance" is rebooted
    Then the operation is rejected
