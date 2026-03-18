@docdb @generated
Feature: Docdb - A Database Cluster Deletion Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_deletion @internal
  Scenario: a database cluster deletion completes
    Given the cluster exists
    And the cluster is "DELETING"
    When a database cluster deletion completes
    Then the cluster is "DELETED"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @complete_cluster_deletion @internal
  Scenario: a database cluster deletion completes fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster deletion completes
    Then the operation is rejected

  @standard @negative @complete_cluster_deletion @internal
  Scenario: a database cluster deletion completes fails when the cluster is not "DELETING"
    Given the cluster exists
    And the cluster is not "DELETING"
    When a database cluster deletion completes
    Then the operation is rejected
