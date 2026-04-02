@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Creation Fails

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @fail_cluster_creation @internal
  Scenario: a "documentdb" "cluster" creation fails
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "CREATING"
    When a "documentdb" "cluster" creation fails
    Then the "documentdb" "cluster" will be in "FAILED" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @fail_cluster_creation @internal
  Scenario: a "documentdb" "cluster" creation fails fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a "documentdb" "cluster" creation fails
    Then the operation is rejected

  @guard @negative @fail_cluster_creation @internal
  Scenario: a "documentdb" "cluster" creation fails fails when the "documentdb" "cluster" was not "CREATING"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "CREATING"
    When a "documentdb" "cluster" creation fails
    Then the operation is rejected
