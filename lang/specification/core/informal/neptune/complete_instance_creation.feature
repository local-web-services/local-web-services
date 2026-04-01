@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Finishes Creating

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_instance_creation @internal
  Scenario: a "neptune" "instance" finishes creating
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "CREATING"
    And the "neptune" "cluster" existed
    And the "neptune" "instance" is the primary
    When a "neptune" "instance" finishes creating
    Then the "neptune" "INSTANCE" will be "AVAILABLE" and the "neptune" "cluster" primary will be updated if applicable
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_instance_creation @internal
  Scenario: a "neptune" "instance" finishes creating fails when the "neptune" "instance" did not exist
    Given the "neptune" "instance" did not exist
    When a "neptune" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "neptune" "instance" finishes creating fails when the "neptune" "instance" was not "CREATING"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was not "CREATING"
    When a "neptune" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "neptune" "instance" finishes creating fails when the "neptune" "cluster" did not exist
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "CREATING"
    And the "neptune" "cluster" did not exist
    When a "neptune" "instance" finishes creating
    Then the operation is rejected

  @guard @negative @complete_instance_creation @internal
  Scenario: a "neptune" "instance" finishes creating fails when the "neptune" "instance" is not the primary
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "CREATING"
    And the "neptune" "cluster" existed
    And the "neptune" "instance" is not the primary
    When a "neptune" "instance" finishes creating
    Then the operation is rejected
