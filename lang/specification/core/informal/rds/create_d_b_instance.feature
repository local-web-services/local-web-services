@rds @generated
Feature: Rds - A "Rds" "Instance" Is Created

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a "rds" "instance" is created
    Given the "rds" "instance" did not already exist
    When a "rds" "instance" is created
    Then the "rds" "instance" will be in "CREATING" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @create_d_b_instance
  Scenario: a "rds" "instance" is created fails when the "rds" "instance" already existed
    Given the "rds" "instance" already existed
    When a "rds" "instance" is created
    Then the operation is rejected
