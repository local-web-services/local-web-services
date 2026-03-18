@neptune @generated
Feature: Neptune - A Cluster Is Restored From A Snapshot

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

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
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @standard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a cluster is restored from a snapshot fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_d_b_cluster_from_snapshot @lifecycle
  Scenario: a cluster is restored from a snapshot fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a cluster is restored from a snapshot
    Then the operation is rejected

  @standard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a cluster is restored from a snapshot fails when the target cluster slot is not available
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is not available
    When a cluster is restored from a snapshot
    Then the operation is rejected
