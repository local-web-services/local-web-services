@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Is Restored From A "Documentdb" "Snapshot"

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @restore_d_b_cluster_from_snapshot
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was "AVAILABLE"
    And the target "documentdb" "cluster" slot is available
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Then the restored documentdb cluster will be in "RESTORING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" fails when the "documentdb" "snapshot" did not exist
    Given the "documentdb" "snapshot" did not exist
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_d_b_cluster_from_snapshot @lifecycle
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" fails when the "documentdb" "snapshot" was not "AVAILABLE"
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was not "AVAILABLE"
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Then the operation is rejected

  @guard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" fails when the target "documentdb" "cluster" slot is not available
    Given the "documentdb" "snapshot" existed
    And the "documentdb" "snapshot" was "AVAILABLE"
    And the target "documentdb" "cluster" slot is not available
    When a "documentdb" "cluster" is restored from a "documentdb" "snapshot"
    Then the operation is rejected
