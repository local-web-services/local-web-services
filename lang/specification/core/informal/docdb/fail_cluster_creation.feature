@docdb @generated
Feature: Docdb - A Database Cluster Creation Fails

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @fail_cluster_creation @internal
  Scenario: a database cluster creation fails
    Given the cluster exists
    And the cluster is "CREATING"
    When a database cluster creation fails
    Then the cluster is in "FAILED" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @fail_cluster_creation @internal
  Scenario: a database cluster creation fails fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster creation fails
    Then the operation is rejected

  @guard @negative @fail_cluster_creation @internal
  Scenario: a database cluster creation fails fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a database cluster creation fails
    Then the operation is rejected
