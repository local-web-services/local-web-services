@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Is Created In An Available Documentdb Cluster

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_instance
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "instance" slot is available
    When a "documentdb" "instance" is created in an available documentdb cluster
    Then the "documentdb" "INSTANCE" will be in "CREATING" state and associated with the "documentdb" "cluster"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @create_d_b_instance
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "cluster" did not exist
    When a "documentdb" "instance" is created in an available documentdb cluster
    Then the operation is rejected

  @guard @negative @create_d_b_instance @lifecycle
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster fails when the "documentdb" "cluster" was not "AVAILABLE"
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was not "AVAILABLE"
    When a "documentdb" "instance" is created in an available documentdb cluster
    Then the operation is rejected

  @guard @negative @create_d_b_instance
  Scenario: a "documentdb" "instance" is created in an available documentdb cluster fails when the "documentdb" "instance" slot is not available
    Given the "documentdb" "cluster" existed
    And the "documentdb" "cluster" was "AVAILABLE"
    And the "documentdb" "instance" slot is not available
    When a "documentdb" "instance" is created in an available documentdb cluster
    Then the operation is rejected
