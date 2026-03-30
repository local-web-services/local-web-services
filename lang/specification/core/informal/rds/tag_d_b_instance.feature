@rds @generated
Feature: Rds - A Tag Is Applied To A Database Instance

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @tag_d_b_instance
  Scenario: a tag is applied to a database instance
    Given the database instance exists
    And the instance is "AVAILABLE"
    When a tag is applied to a database instance
    Then the instance tag state is unchanged (no-op model)
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @tag_d_b_instance
  Scenario: a tag is applied to a database instance fails when the database instance does not exist
    Given the database instance does not exist
    When a tag is applied to a database instance
    Then the operation is rejected

  @guard @negative @tag_d_b_instance @lifecycle
  Scenario: a tag is applied to a database instance fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When a tag is applied to a database instance
    Then the operation is rejected
