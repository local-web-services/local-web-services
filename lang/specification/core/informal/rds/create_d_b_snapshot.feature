@rds @generated
Feature: Rds - A Database Snapshot Is Created From An Instance

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_snapshot
  Scenario: a database snapshot is created from an instance
    Given the database instance exists
    And the instance is "AVAILABLE"
    And a snapshot slot is available
    When a database snapshot is created from an instance
    Then the snapshot is "CREATING" and the instance is in "BACKING_UP" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @create_d_b_snapshot
  Scenario: a database snapshot is created from an instance fails when the database instance does not exist
    Given the database instance does not exist
    When a database snapshot is created from an instance
    Then the operation is rejected

  @standard @negative @create_d_b_snapshot @lifecycle
  Scenario: a database snapshot is created from an instance fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When a database snapshot is created from an instance
    Then the operation is rejected

  @standard @negative @internal @create_d_b_snapshot
  Scenario: a database snapshot is created from an instance fails when no snapshot slot is available
    Given the database instance exists
    And the instance is "AVAILABLE"
    And no snapshot slot is available
    When a database snapshot is created from an instance
    Then the operation is rejected
