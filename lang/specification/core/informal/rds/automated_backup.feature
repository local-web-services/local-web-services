@rds @generated
Feature: Rds - An Automated Backup Runs On An Available Instance

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @automated_backup @internal
  Scenario: an automated backup runs on an available instance
    Given the database instance exists
    And the instance is "AVAILABLE"
    And a snapshot slot is available
    When an automated backup runs on an available instance
    Then a snapshot is "CREATING" and the instance is in "BACKING_UP" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available instance fails when the database instance does not exist
    Given the database instance does not exist
    When an automated backup runs on an available instance
    Then the operation is rejected

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available instance fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When an automated backup runs on an available instance
    Then the operation is rejected

  @guard @negative @automated_backup @internal
  Scenario: an automated backup runs on an available instance fails when no snapshot slot is available
    Given the database instance exists
    And the instance is "AVAILABLE"
    And no snapshot slot is available
    When an automated backup runs on an available instance
    Then the operation is rejected
