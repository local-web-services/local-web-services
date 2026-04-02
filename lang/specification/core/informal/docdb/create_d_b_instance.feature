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
    Then the "documentdb" "instance" will be in "CREATING" state and associated with the "documentdb" "cluster"
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

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
