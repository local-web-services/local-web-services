@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Is Deleted

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_cluster
  Scenario: a "documentdb" "cluster" is deleted
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "cluster" has no non-deleted instances
    When a "documentdb" "cluster" is deleted
    Then the "documentdb" "cluster" will be in "DELETING" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @delete_d_b_cluster
  Scenario: a "documentdb" "cluster" is deleted fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a "documentdb" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster @lifecycle
  Scenario: a "documentdb" "cluster" is deleted fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster @lifecycle
  Scenario: a "documentdb" "cluster" is deleted fails when the "documentdb" "cluster" has non-deleted instances
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "cluster" has non-deleted instances
    When a "documentdb" "cluster" is deleted
    Then the operation is rejected
