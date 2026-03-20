@neptune @generated
Feature: Neptune - A Database Cluster Snapshot Deletion Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

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
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @standard @negative @complete_snapshot_deletion @internal
  Scenario: a database cluster snapshot deletion completes fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database cluster snapshot deletion completes
    Then the operation is rejected

  @standard @negative @complete_snapshot_deletion @internal
  Scenario: a database cluster snapshot deletion completes fails when the snapshot is not "DELETING"
    Given the snapshot exists
    And the snapshot is not "DELETING"
    When a database cluster snapshot deletion completes
    Then the operation is rejected
