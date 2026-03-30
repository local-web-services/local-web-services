@rds @generated
Feature: Rds - Multi-Az Is Enabled On A Database Instance

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @enable_multi_a_z
  Scenario: multi-"AZ" is enabled on a database instance
    Given the database instance exists
    And the instance is "AVAILABLE"
    When multi-"AZ" is enabled on a database instance
    Then the instance is configured for multi-"AZ" deployment
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @enable_multi_a_z
  Scenario: multi-"AZ" is enabled on a database instance fails when the database instance does not exist
    Given the database instance does not exist
    When multi-"AZ" is enabled on a database instance
    Then the operation is rejected

  @guard @negative @enable_multi_a_z @lifecycle
  Scenario: multi-"AZ" is enabled on a database instance fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When multi-"AZ" is enabled on a database instance
    Then the operation is rejected
