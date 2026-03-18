@docdb @generated
Feature: Docdb - A Database Instance Modification Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_modification @internal
  Scenario: a database instance modification completes
    Given the instance exists
    And the instance is "MODIFYING"
    When a database instance modification completes
    Then the instance returns to "AVAILABLE" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @complete_instance_modification @internal
  Scenario: a database instance modification completes fails when the instance does not exist
    Given the instance does not exist
    When a database instance modification completes
    Then the operation is rejected

  @standard @negative @complete_instance_modification @internal
  Scenario: a database instance modification completes fails when the instance is not "MODIFYING"
    Given the instance exists
    And the instance is not "MODIFYING"
    When a database instance modification completes
    Then the operation is rejected
