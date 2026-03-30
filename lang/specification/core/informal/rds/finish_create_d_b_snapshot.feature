@rds @generated
Feature: Rds - A Database Snapshot Finishes Creating

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_create_d_b_snapshot @internal
  Scenario: a database snapshot finishes creating
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the instance exists
    And the instance is "BACKING_UP"
    When a database snapshot finishes creating
    Then the snapshot is "AVAILABLE" and the instance returns to "AVAILABLE" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a database snapshot finishes creating fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database snapshot finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a database snapshot finishes creating fails when the snapshot is not "CREATING"
    Given the snapshot exists
    And the snapshot is not "CREATING"
    When a database snapshot finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a database snapshot finishes creating fails when the instance does not exist
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the instance does not exist
    When a database snapshot finishes creating
    Then the operation is rejected

  @guard @negative @finish_create_d_b_snapshot @internal
  Scenario: a database snapshot finishes creating fails when the instance is not "BACKING_UP"
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the instance exists
    And the instance is not "BACKING_UP"
    When a database snapshot finishes creating
    Then the operation is rejected
