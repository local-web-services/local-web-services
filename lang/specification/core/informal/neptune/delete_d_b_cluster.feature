@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Is Deleted

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @delete_d_b_cluster
  Scenario: a "neptune" "cluster" is deleted
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "cluster" has no non-deleted instances
    When a "neptune" "cluster" is deleted
    Then the "neptune" "cluster" will be in "DELETING" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @delete_d_b_cluster
  Scenario: a "neptune" "cluster" is deleted fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster @lifecycle
  Scenario: a "neptune" "cluster" is deleted fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a "neptune" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_d_b_cluster @lifecycle
  Scenario: a "neptune" "cluster" is deleted fails when the "neptune" "cluster" has non-deleted instances
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "cluster" has non-deleted instances
    When a "neptune" "cluster" is deleted
    Then the operation is rejected
