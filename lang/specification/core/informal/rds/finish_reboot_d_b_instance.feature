@rds @generated
Feature: Rds - A Database Instance Reboot Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_reboot_d_b_instance @internal
  Scenario: a database instance reboot completes
    Given the database instance exists
    And the instance is "REBOOTING"
    When a database instance reboot completes
    Then the instance returns to "AVAILABLE" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @finish_reboot_d_b_instance @internal
  Scenario: a database instance reboot completes fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance reboot completes
    Then the operation is rejected

  @standard @negative @finish_reboot_d_b_instance @internal
  Scenario: a database instance reboot completes fails when the instance is not "REBOOTING"
    Given the database instance exists
    And the instance is not "REBOOTING"
    When a database instance reboot completes
    Then the operation is rejected
