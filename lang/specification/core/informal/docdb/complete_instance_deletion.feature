@docdb @generated
Feature: Docdb - A "Documentdb" "Instance" Deletion Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_deletion @internal
  Scenario: a "documentdb" "instance" deletion completes
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "DELETING"
    And the "documentdb" "cluster" existed
    And the "documentdb" "instance" is the primary of the "documentdb" "cluster"
    When a "documentdb" "instance" deletion completes
    Then the "documentdb" "INSTANCE" will be "DELETED" and the "documentdb" "cluster" primary will be cleared if applicable
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "documentdb" "instance" deletion completes fails when the "documentdb" "instance" did not exist
    Given the "documentdb" "instance" did not exist
    When a "documentdb" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "documentdb" "instance" deletion completes fails when the "documentdb" "instance" was not "DELETING"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was not "DELETING"
    When a "documentdb" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "documentdb" "instance" deletion completes fails when the "documentdb" "cluster" did not exist
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "DELETING"
    And the "documentdb" "cluster" did not exist
    When a "documentdb" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "documentdb" "instance" deletion completes fails when the "documentdb" "instance" is not the primary of the "documentdb" "cluster"
    Given the "documentdb" "instance" existed
    And the "documentdb" "instance" was "DELETING"
    And the "documentdb" "cluster" existed
    And the "documentdb" "instance" is not the primary of the "documentdb" "cluster"
    When a "documentdb" "instance" deletion completes
    Then the operation is rejected
