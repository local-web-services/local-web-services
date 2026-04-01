@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Documentdb Snapshot Deletion Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was "DELETING"
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    Then the "documentdb" "SNAPSHOT" will be "DELETED"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes fails when the "documentdb" "snapshot" did not exist
    Given the "documentdb" "snapshot" did not exist
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: a "documentdb" "cluster" documentdb snapshot deletion completes fails when the "documentdb" "snapshot" was not "DELETING"
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was not "DELETING"
    When a "documentdb" "cluster" documentdb snapshot deletion completes
    Then the operation is rejected
