@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Documentdb Snapshot Finishes Creating

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was "CREATING"
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    Then the "documentdb" "SNAPSHOT" will be "AVAILABLE"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating fails when the "documentdb" "snapshot" did not exist
    Given the "documentdb" "snapshot" did not exist
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot finishes creating fails when the "documentdb" "snapshot" was not "CREATING"
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was not "CREATING"
    When a "documentdb" "cluster" documentdb snapshot finishes creating
    Then the operation is rejected
