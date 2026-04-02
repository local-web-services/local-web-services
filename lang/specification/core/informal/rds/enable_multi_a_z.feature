@rds @generated
Feature: Rds - Multi-Az Was "Enabled" On A "Rds" "Instance"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @enable_multi_a_z
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    Then the "rds" "instance" will be configured for multi-"AZ" deployment
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @enable_multi_a_z
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    Then the operation is rejected

  @guard @negative @enable_multi_a_z @lifecycle
  Scenario: multi-"AZ" was "ENABLED" on a "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When multi-"AZ" was "ENABLED" on a "rds" "instance"
    Then the operation is rejected
