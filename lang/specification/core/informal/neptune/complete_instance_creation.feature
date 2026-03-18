@neptune @generated
Feature: Neptune - A Database Instance Finishes Creating

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

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
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

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
