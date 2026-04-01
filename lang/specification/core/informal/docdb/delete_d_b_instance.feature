@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Is Deleted

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_instance
  Scenario: a "documentdb" "instance" is deleted
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "AVAILABLE"
    When a "documentdb" "instance" is deleted
    Then the "documentdb" "instance" will be in "DELETING" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @delete_d_b_instance
  Scenario: a "documentdb" "instance" is deleted fails when the "documentdb" "instance" did not exist
    Given the "documentdb" "instance" did not exist
    When a "documentdb" "instance" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_instance @lifecycle
  Scenario: a "documentdb" "instance" is deleted fails when the "documentdb" "instance" was not "AVAILABLE"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was not "AVAILABLE"
    When a "documentdb" "instance" is deleted
    Then the operation is rejected
