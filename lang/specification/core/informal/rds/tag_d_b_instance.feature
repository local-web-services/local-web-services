@rds @generated
Feature: Rds - A Tag Is Applied To A "Rds" "Instance"

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @tag_d_b_instance
  Scenario: a tag is applied to a "rds" "instance"
    Given the "rds" "instance" existed
    And the "rds" "instance" was "AVAILABLE"
    When a tag is applied to a "rds" "instance"
    Then the "rds" "instance" tag state will be unchanged (no-op model)
    And every "rds" "instance" has a valid status
    And every "rds" "snapshot" has a valid status
    And every backing-up "rds" "instance" has a corresponding in-progress "rds" "snapshot"

  @guard @negative @tag_d_b_instance
  Scenario: a tag is applied to a "rds" "instance" fails when the "rds" "instance" did not exist
    Given the "rds" "instance" did not exist
    When a tag is applied to a "rds" "instance"
    Then the operation is rejected

  @guard @negative @tag_d_b_instance @lifecycle
  Scenario: a tag is applied to a "rds" "instance" fails when the "rds" "instance" was not "AVAILABLE"
    Given the "rds" "instance" existed
    And the "rds" "instance" was not "AVAILABLE"
    When a tag is applied to a "rds" "instance"
    Then the operation is rejected
