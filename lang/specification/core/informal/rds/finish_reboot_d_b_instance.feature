@rds @generated
Feature: Rds - A "Rds" "Instance" Reboot Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_reboot_d_b_instance @internal
  Scenario: a "rds" "instance" reboot completes
    Given the "rds" "instance" existed
    And the "rds" "instance" was "REBOOTING"
    When a "rds" "instance" reboot completes
    Then the "rds" "instance" returns to "AVAILABLE" state
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @finish_reboot_d_b_instance @internal
  Scenario: a "rds" "instance" reboot completes fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" reboot completes
    Then the operation is rejected

  @guard @negative @finish_reboot_d_b_instance @internal
  Scenario: a "rds" "instance" reboot completes fails when the "rds" "instance" was not "REBOOTING"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "REBOOTING"
    When a "rds" "instance" reboot completes
    Then the operation is rejected
