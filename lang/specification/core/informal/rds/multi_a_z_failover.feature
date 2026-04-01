@rds @generated
Feature: Rds - A Multi-Az Failover Is Triggered On A "Rds" "Instance"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" has multi-"AZ" enabled
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    Then the "rds" "instance" will be in "MODIFYING" state during promotion
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    Then the operation is rejected

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    Then the operation is rejected

  @guard @negative @multi_a_z_failover @internal
  Scenario: a multi-"AZ" failover is triggered on a "rds" "instance" fails when the "rds" "instance" does not have multi-"AZ" enabled
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    And the "rds" "instance" does not have multi-"AZ" enabled
    When a multi-"AZ" failover is triggered on a "rds" "instance"
    Then the operation is rejected
