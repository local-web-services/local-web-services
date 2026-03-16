@rds @generated
Feature: Rds - A Database Instance Is Rebooted

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @reboot_d_b_instance
  Scenario: a database instance is rebooted
    Given the database instance exists
    And the instance is "AVAILABLE"
    When a database instance is rebooted
    Then the instance is in "REBOOTING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @reboot_d_b_instance
  Scenario: a database instance is rebooted fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance is rebooted
    Then the operation is rejected

  @standard @negative @reboot_d_b_instance @lifecycle
  Scenario: a database instance is rebooted fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When a database instance is rebooted
    Then the operation is rejected
