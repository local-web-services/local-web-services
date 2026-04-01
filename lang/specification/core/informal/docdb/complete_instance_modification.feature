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
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

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
