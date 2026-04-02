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
    Then the "documentdb" "snapshot" will be "DELETED"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

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
