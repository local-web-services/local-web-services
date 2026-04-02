@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Is Restored From A Neptune Snapshot

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @restore_d_b_cluster_from_snapshot
  Scenario: a "neptune" "cluster" is restored from a neptune snapshot
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was "AVAILABLE"
    And the target "neptune" "cluster" slot is available
    When a "neptune" "cluster" is restored from a neptune snapshot
    Then the restored "neptune" "cluster" will be in "RESTORING" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a "neptune" "cluster" is restored from a neptune snapshot fails when the "neptune" "snapshot" did not exist
    Given the "neptune" "snapshot" did not exist
    When a "neptune" "cluster" is restored from a neptune snapshot
    Then the operation is rejected

  @guard @negative @restore_d_b_cluster_from_snapshot @lifecycle
  Scenario: a "neptune" "cluster" is restored from a neptune snapshot fails when the "neptune" "snapshot" was not "AVAILABLE"
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was not "AVAILABLE"
    When a "neptune" "cluster" is restored from a neptune snapshot
    Then the operation is rejected

  @guard @negative @restore_d_b_cluster_from_snapshot
  Scenario: a "neptune" "cluster" is restored from a neptune snapshot fails when the target "neptune" "cluster" slot is not available
    Given the "neptune" "snapshot" existed
    And the "neptune" "snapshot" was "AVAILABLE"
    And the target "neptune" "cluster" slot is not available
    When a "neptune" "cluster" is restored from a neptune snapshot
    Then the operation is rejected
