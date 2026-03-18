@rds @generated
Feature: Rds - A Database Instance Deletion Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_d_b_instance @internal
  Scenario: a database instance deletion completes
    Given the database instance exists
    And the instance is "DELETING"
    When a database instance deletion completes
    Then the instance is "DELETED"
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @standard @negative @finish_delete_d_b_instance @internal
  Scenario: a database instance deletion completes fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance deletion completes
    Then the operation is rejected

  @standard @negative @finish_delete_d_b_instance @internal
  Scenario: a database instance deletion completes fails when the instance is not "DELETING"
    Given the database instance exists
    And the instance is not "DELETING"
    When a database instance deletion completes
    Then the operation is rejected
