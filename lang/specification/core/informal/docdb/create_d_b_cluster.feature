@docdb @generated
Feature: Docdb - A "Documentdb" "Cluster" Is Created

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster
  Scenario: a "documentdb" "cluster" is created
    Given the "documentdb" "cluster" did not already exist
    When a "documentdb" "cluster" is created
    Then the "documentdb" "cluster" will be in "CREATING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @create_d_b_cluster
  Scenario: a "documentdb" "cluster" is created fails when the "documentdb" "cluster" already existed
    Given the "documentdb" "cluster" already existed
    When a "documentdb" "cluster" is created
    Then the operation is rejected
