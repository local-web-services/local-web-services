@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Documentdb Snapshot Is Created

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster_snapshot
  Scenario: a "documentdb" "cluster" documentdb snapshot is created
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "snapshot" slot is available
    When a "documentdb" "cluster" documentdb snapshot is created
    Then the "documentdb" "SNAPSHOT" will be in "CREATING" state and linked to the "documentdb" "cluster"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @create_d_b_cluster_snapshot
  Scenario: a "documentdb" "cluster" documentdb snapshot is created fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a "documentdb" "cluster" documentdb snapshot is created
    Then the operation is rejected

  @guard @negative @create_d_b_cluster_snapshot @lifecycle
  Scenario: a "documentdb" "cluster" documentdb snapshot is created fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "cluster" documentdb snapshot is created
    Then the operation is rejected

  @guard @negative @create_d_b_cluster_snapshot
  Scenario: a "documentdb" "cluster" documentdb snapshot is created fails when the "documentdb" "snapshot" slot is not available
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "snapshot" slot is not available
    When a "documentdb" "cluster" documentdb snapshot is created
    Then the operation is rejected
