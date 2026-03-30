@docdb @generated
Feature: Docdb - A Database Cluster Is Created

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster
  Scenario: a database cluster is created
    Given the cluster does not already exist
    When a database cluster is created
    Then the cluster is in "CREATING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @create_d_b_cluster
  Scenario: a database cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a database cluster is created
    Then the operation is rejected
