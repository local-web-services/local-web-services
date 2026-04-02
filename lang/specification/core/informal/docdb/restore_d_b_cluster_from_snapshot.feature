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
    Then the restored "documentdb" "cluster" will be in "RESTORING" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

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
