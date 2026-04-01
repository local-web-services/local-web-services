@rds @generated
Feature: Rds - A "Rds" "Instance" Deletion Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_d_b_instance @internal
  Scenario: a "rds" "instance" deletion completes
    Given the "rds" "instance" existed
    And the "rds" "instance" was "DELETING"
    When a "rds" "instance" deletion completes
    Then the "rds" "instance" will be "DELETED"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_delete_d_b_instance @internal
  Scenario: a "rds" "instance" deletion completes fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @finish_delete_d_b_instance @internal
  Scenario: a "rds" "instance" deletion completes fails when the "rds" "instance" was not "DELETING"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "DELETING"
    When a "rds" "instance" deletion completes
    Then the operation is rejected
