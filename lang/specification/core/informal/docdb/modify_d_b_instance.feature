@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Configuration Is Modified

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_instance
  Scenario: a "documentdb" "instance" configuration is modified
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "AVAILABLE"
    And the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    When a "documentdb" "instance" configuration is modified
    Then the "documentdb" "instance" will be in "MODIFYING" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @modify_d_b_instance
  Scenario: a "documentdb" "instance" configuration is modified fails when the "documentdb" "instance" did not exist
    Given the "documentdb" "instance" did not exist
    When a "documentdb" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance @lifecycle
  Scenario: a "documentdb" "instance" configuration is modified fails when the "documentdb" "instance" was not "AVAILABLE"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was not "AVAILABLE"
    When a "documentdb" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance
  Scenario: a "documentdb" "instance" configuration is modified fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "AVAILABLE"
    And the "documentdb" "cluster" did not exist
    When a "documentdb" "instance" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_instance @lifecycle
  Scenario: a "documentdb" "instance" configuration is modified fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "AVAILABLE"
    And the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "instance" configuration is modified
    Then the operation is rejected
