@neptune @generated
Feature: Neptune - A Database Cluster Snapshot Finishes Creating

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a database cluster snapshot finishes creating
    Given the snapshot exists
    And the snapshot is "CREATING"
    When a database cluster snapshot finishes creating
    Then the snapshot is "AVAILABLE"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a database cluster snapshot finishes creating fails when the snapshot does not exist
    Given the snapshot does not exist
    When a database cluster snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a database cluster snapshot finishes creating fails when the snapshot is not "CREATING"
    Given the snapshot exists
    And the snapshot is not "CREATING"
    When a database cluster snapshot finishes creating
    Then the operation is rejected
