@docdb @generated
Feature: Docdb - A Database Cluster Restore From Snapshot Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes
    Given the cluster exists
    And the cluster is "RESTORING"
    When a database cluster restore from snapshot completes
    Then the cluster is "AVAILABLE"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster restore from snapshot completes
    Then the operation is rejected

  @standard @negative @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes fails when the cluster is not "RESTORING"
    Given the cluster exists
    And the cluster is not "RESTORING"
    When a database cluster restore from snapshot completes
    Then the operation is rejected
