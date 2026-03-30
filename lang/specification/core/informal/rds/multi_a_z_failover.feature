@rds @generated
Feature: Rds - A Multi-Az Failover Is Triggered On An Instance

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on an instance
    Given the database instance exists
    And the instance is "AVAILABLE"
    And the instance has multi-"AZ" enabled
    When a multi-"AZ" failover is triggered on an instance
    Then the instance enters "MODIFYING" state during promotion
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on an instance fails when the database instance does not exist
    Given the database instance does not exist
    When a multi-"AZ" failover is triggered on an instance
    Then the operation is rejected

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on an instance fails when the instance is not "AVAILABLE"
    Given the database instance exists
    And the instance is not "AVAILABLE"
    When a multi-"AZ" failover is triggered on an instance
    Then the operation is rejected

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on an instance fails when the instance does not have multi-"AZ" enabled
    Given the database instance exists
    And the instance is "AVAILABLE"
    And the instance does not have multi-"AZ" enabled
    When a multi-"AZ" failover is triggered on an instance
    Then the operation is rejected
