@neptune @generated
Feature: Neptune - A Database Cluster Snapshot Is Deleted

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_cluster_snapshot
  Scenario: a database cluster snapshot is deleted
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    When a database cluster snapshot is deleted
    Then the snapshot is in "DELETING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @delete_d_b_cluster_snapshot
  Scenario: a database cluster snapshot is deleted fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database cluster snapshot is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster_snapshot @lifecycle
  Scenario: a database cluster snapshot is deleted fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a database cluster snapshot is deleted
    Then the operation is rejected
