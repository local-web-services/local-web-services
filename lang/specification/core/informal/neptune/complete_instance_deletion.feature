@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Deletion Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_deletion @internal
  Scenario: a "neptune" "instance" deletion completes
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "DELETING"
    And the "neptune" "cluster" existed
    And the "neptune" "instance" is the primary of the "neptune" "cluster"
    When a "neptune" "instance" deletion completes
    Then the "neptune" "INSTANCE" will be "DELETED" and the "neptune" "cluster" primary will be cleared if applicable
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "neptune" "instance" deletion completes fails when the "neptune" "instance" did not exist
    Given the "neptune" "instance" did not exist
    When a "neptune" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "neptune" "instance" deletion completes fails when the "neptune" "instance" was not "DELETING"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was not "DELETING"
    When a "neptune" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "neptune" "instance" deletion completes fails when the "neptune" "cluster" did not exist
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "DELETING"
    And the "neptune" "cluster" did not exist
    When a "neptune" "instance" deletion completes
    Then the operation is rejected

  @guard @negative @complete_instance_deletion @internal
  Scenario: a "neptune" "instance" deletion completes fails when the "neptune" "instance" is not the primary of the "neptune" "cluster"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "DELETING"
    And the "neptune" "cluster" existed
    And the "neptune" "instance" is not the primary of the "neptune" "cluster"
    When a "neptune" "instance" deletion completes
    Then the operation is rejected
