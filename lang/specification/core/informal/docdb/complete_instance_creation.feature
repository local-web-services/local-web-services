@docdb @generated
Feature: Docdb - A Database Instance Finishes Creating

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_creation @internal
  Scenario: a database instance finishes creating
    Given the instance exists
    And the instance is "CREATING"
    And the cluster exists
    And the instance is the primary
    When a database instance finishes creating
    Then the instance is "AVAILABLE" and the cluster primary is updated if applicable
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @standard @negative @complete_instance_creation @internal
  Scenario: a database instance finishes creating fails when the instance does not exist
    Given the instance does not exist
    When a database instance finishes creating
    Then the operation is rejected

  @standard @negative @complete_instance_creation @internal
  Scenario: a database instance finishes creating fails when the instance is not "CREATING"
    Given the instance exists
    And the instance is not "CREATING"
    When a database instance finishes creating
    Then the operation is rejected

  @standard @negative @complete_instance_creation @internal
  Scenario: a database instance finishes creating fails when the cluster does not exist
    Given the instance exists
    And the instance is "CREATING"
    And the cluster does not exist
    When a database instance finishes creating
    Then the operation is rejected

  @standard @negative @complete_instance_creation @internal
  Scenario: a database instance finishes creating fails when the instance is not the primary
    Given the instance exists
    And the instance is "CREATING"
    And the cluster exists
    And the instance is not the primary
    When a database instance finishes creating
    Then the operation is rejected
