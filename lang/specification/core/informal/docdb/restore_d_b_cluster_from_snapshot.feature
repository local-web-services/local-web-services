@docdb @generated
Feature: Docdb - A Cluster Is Restored From A Snapshot

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @restore_d_b_cluster_from_snapshot
  Scenario: a cluster is restored from a snapshot
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is available
    When a cluster is restored from a snapshot
    Then the restored cluster is in "RESTORING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a cluster is restored from a snapshot fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @guard @negative @restore_d_b_cluster_from_snapshot @lifecycle
  Scenario: a cluster is restored from a snapshot fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @guard @negative @internal @restore_d_b_cluster_from_snapshot
  Scenario: a cluster is restored from a snapshot fails when the target cluster slot is not available
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is not available
    When a cluster is restored from a snapshot
    Then the operation is rejected
