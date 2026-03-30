@rds @generated
Feature: Rds - A Database Instance Modification Completes

  # Generated from FizzBee spec: rds.fizz
  # Safety invariants: ValidDBInstanceStatus, ValidDBSnapshotStatus, BackingUpInstanceHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @finish_modify_d_b_instance @internal
  Scenario: a database instance modification completes
    Given the database instance exists
    And the instance is "MODIFYING"
    When a database instance modification completes
    Then the instance returns to "AVAILABLE" state
    And every database instance has a valid status
    And every database snapshot has a valid status
    And every backing-up instance has a corresponding in-progress snapshot

  @guard @negative @finish_modify_d_b_instance @internal
  Scenario: a database instance modification completes fails when the database instance does not exist
    Given the database instance does not exist
    When a database instance modification completes
    Then the operation is rejected

  @guard @negative @finish_modify_d_b_instance @internal
  Scenario: a database instance modification completes fails when the instance is not "MODIFYING"
    Given the database instance exists
    And the instance is not "MODIFYING"
    When a database instance modification completes
    Then the operation is rejected
