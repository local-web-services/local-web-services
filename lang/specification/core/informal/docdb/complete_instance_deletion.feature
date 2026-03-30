@docdb @generated
Feature: Docdb - A Database Instance Deletion Completes

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_deletion @internal
  Scenario: a database instance deletion completes
    Given the instance exists
    And the instance is "DELETING"
    And the cluster exists
    And the instance is the primary of the cluster
    When a database instance deletion completes
    Then the instance is "DELETED" and the cluster primary is cleared if applicable
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @complete_instance_deletion @internal
  Scenario: a database instance deletion completes fails when the instance does not exist
    Given the instance does not exist
    When a database instance deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a database instance deletion completes fails when the instance is not "DELETING"
    Given the instance exists
    And the instance is not "DELETING"
    When a database instance deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a database instance deletion completes fails when the cluster does not exist
    Given the instance exists
    And the instance is "DELETING"
    And the cluster does not exist
    When a database instance deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a database instance deletion completes fails when the instance is not the primary of the cluster
    Given the instance exists
    And the instance is "DELETING"
    And the cluster exists
    And the instance is not the primary of the cluster
    When a database instance deletion completes
    Then the operation is rejected
