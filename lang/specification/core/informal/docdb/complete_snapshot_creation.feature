@docdb @generated
Feature: Docdb - A Database Cluster Snapshot Finishes Creating

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

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
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

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
