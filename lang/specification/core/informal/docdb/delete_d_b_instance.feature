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
    Then the "documentdb" "INSTANCE" will be in "DELETING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

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
