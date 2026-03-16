@docdb @generated
Feature: Docdb - A Database Cluster Snapshot Is Created

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster_snapshot
  Scenario: a database cluster snapshot is created
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the snapshot slot is available
    When a database cluster snapshot is created
    Then the snapshot is in "CREATING" state and linked to the cluster
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @create_d_b_cluster_snapshot
  Scenario: a database cluster snapshot is created fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster snapshot is created
    Then the operation is rejected

  @standard @negative @create_d_b_cluster_snapshot @lifecycle
  Scenario: a database cluster snapshot is created fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a database cluster snapshot is created
    Then the operation is rejected

  @standard @negative @create_d_b_cluster_snapshot
  Scenario: a database cluster snapshot is created fails when the snapshot slot is not available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the snapshot slot is not available
    When a database cluster snapshot is created
    Then the operation is rejected
