@neptune @generated
Feature: Neptune - A "Neptune" "Instance" Is Deleted

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_instance
  Scenario: a "neptune" "instance" is deleted
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was "AVAILABLE"
    When a "neptune" "instance" is deleted
    Then the "neptune" "instance" will be in "DELETING" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @delete_d_b_instance
  Scenario: a "neptune" "instance" is deleted fails when the "neptune" "instance" did not exist
    Given the "neptune" "instance" did not exist
    When a "neptune" "instance" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_instance @lifecycle
  Scenario: a "neptune" "instance" is deleted fails when the "neptune" "instance" was not "AVAILABLE"
    Given the "neptune" "instance" existed
    And the "neptune" "instance" was not "AVAILABLE"
    When a "neptune" "instance" is deleted
    Then the operation is rejected
