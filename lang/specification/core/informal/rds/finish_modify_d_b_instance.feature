@rds @generated
Feature: Rds - A "Rds" "Instance" Modification Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_modify_d_b_instance @internal
  Scenario: a "rds" "instance" modification completes
    Given the "rds" "instance" existed
    And the "rds" "instance" was "MODIFYING"
    When a "rds" "instance" modification completes
    Then the "rds" "instance" returns to "AVAILABLE" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_modify_d_b_instance @internal
  Scenario: a "rds" "instance" modification completes fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a "rds" "instance" modification completes
    Then the operation is rejected

  @guard @negative @finish_modify_d_b_instance @internal
  Scenario: a "rds" "instance" modification completes fails when the "rds" "instance" was not "MODIFYING"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "MODIFYING"
    When a "rds" "instance" modification completes
    Then the operation is rejected
