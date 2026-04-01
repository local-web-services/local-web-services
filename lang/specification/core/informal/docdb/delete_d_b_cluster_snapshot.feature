@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Documentdb Snapshot Is Deleted

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_cluster_snapshot
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was "AVAILABLE"
    When a "documentdb" "cluster" documentdb snapshot is deleted
    Then the "documentdb" "snapshot" will be in "DELETING" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @delete_d_b_cluster_snapshot
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted fails when the "documentdb" "snapshot" did not exist
    Given the "documentdb" "snapshot" did not exist
    When a "documentdb" "cluster" documentdb snapshot is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster_snapshot @lifecycle
  Scenario: a "documentdb" "cluster" documentdb snapshot is deleted fails when the "documentdb" "snapshot" was not "AVAILABLE"
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was not "AVAILABLE"
    When a "documentdb" "cluster" documentdb snapshot is deleted
    Then the operation is rejected
