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
    Then the "documentdb" "SNAPSHOT" will be in "DELETING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

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
