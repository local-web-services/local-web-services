@docdb @generated
Feature: Docdb - A Database Cluster Snapshot Deletion Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a database cluster snapshot deletion completes
    Given the snapshot exists
    And the snapshot is "DELETING"
    When a database cluster snapshot deletion completes
    Then the snapshot is "DELETED"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a database cluster snapshot deletion completes fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database cluster snapshot deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a database cluster snapshot deletion completes fails when the snapshot is not "DELETING"
    Given the snapshot exists
    And the snapshot is not "DELETING"
    When a database cluster snapshot deletion completes
    Then the operation is rejected
