@neptune @generated
Feature: Neptune - A Database Instance Modification Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

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
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_instance_modification @internal
  Scenario: a database instance modification completes fails when the instance does not exist
    Given the instance does not exist
    When a database instance modification completes
    Then the operation is rejected

  @guard @negative @complete_instance_modification @internal
  Scenario: a database instance modification completes fails when the instance is not "MODIFYING"
    Given the instance exists
    And the instance is not "MODIFYING"
    When a database instance modification completes
    Then the operation is rejected
