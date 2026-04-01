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
    Then the "neptune" "SNAPSHOT" will be in "CREATING" state and linked to the "neptune" "cluster"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

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
