@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Neptune Snapshot Is Created

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster_snapshot
  Scenario: a "neptune" "cluster" neptune snapshot is created
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "snapshot" slot is available
    When a "neptune" "cluster" neptune snapshot is created
    Then the "neptune" "snapshot" will be in "CREATING" state and linked to the "neptune" "cluster"
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @create_d_b_cluster_snapshot
  Scenario: a "neptune" "cluster" neptune snapshot is created fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" neptune snapshot is created
    Then the operation is rejected

  @guard @negative @create_d_b_cluster_snapshot @lifecycle
  Scenario: a "neptune" "cluster" neptune snapshot is created fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a "neptune" "cluster" neptune snapshot is created
    Then the operation is rejected

  @guard @negative @create_d_b_cluster_snapshot
  Scenario: a "neptune" "cluster" neptune snapshot is created fails when the "neptune" "snapshot" slot is not available
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And the "neptune" "snapshot" slot is not available
    When a "neptune" "cluster" neptune snapshot is created
    Then the operation is rejected
