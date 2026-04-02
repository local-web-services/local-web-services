@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Modification Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_modification @internal
  Scenario: a "documentdb" "instance" modification completes
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "MODIFYING"
    When a "documentdb" "instance" modification completes
    Then the "documentdb" "instance" returns to "AVAILABLE" state
    And every "documentdb" "cluster" has a valid status
    And every "documentdb" "instance" has a valid status
    And every "documentdb" "snapshot" has a valid status
    And a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s
    And a failed "documentdb" "cluster" has no available "documentdb" "instance"s
    And a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s
    And every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted

  @guard @negative @complete_instance_modification @internal
  Scenario: a "documentdb" "instance" modification completes fails when the "documentdb" "instance" did not exist
    Given the "documentdb" "instance" did not exist
    When a "documentdb" "instance" modification completes
    Then the operation is rejected

  @guard @negative @complete_instance_modification @internal
  Scenario: a "documentdb" "instance" modification completes fails when the "documentdb" "instance" was not "MODIFYING"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was not "MODIFYING"
    When a "documentdb" "instance" modification completes
    Then the operation is rejected
