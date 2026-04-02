@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Restore From Documentdb Snapshot Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "RESTORING"
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    Then the "documentdb" "cluster" will be "AVAILABLE"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @complete_cluster_restore @internal
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    Then the operation is rejected

  @guard @negative @complete_cluster_restore @internal
  Scenario: a "documentdb" "cluster" restore from documentdb snapshot completes fails when the "documentdb" "cluster" was not "RESTORING"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "RESTORING"
    When a "documentdb" "cluster" restore from documentdb snapshot completes
    Then the operation is rejected
