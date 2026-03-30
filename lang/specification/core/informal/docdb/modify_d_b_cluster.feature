@docdb @generated
Feature: Docdb - A Database Cluster Configuration Is Modified

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_cluster
  Scenario: a database cluster configuration is modified
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a database cluster configuration is modified
    Then the cluster is in "MODIFYING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @modify_d_b_cluster
  Scenario: a database cluster configuration is modified fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_cluster @lifecycle
  Scenario: a database cluster configuration is modified fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a database cluster configuration is modified
    Then the operation is rejected
