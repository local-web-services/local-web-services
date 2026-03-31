@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Configuration Is Modified

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_cluster
  Scenario: a "neptune" "cluster" configuration is modified
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    When a "neptune" "cluster" configuration is modified
    Then the "neptune" "cluster" will be in "MODIFYING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @modify_d_b_cluster
  Scenario: a "neptune" "cluster" configuration is modified fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_d_b_cluster @lifecycle
  Scenario: a "neptune" "cluster" configuration is modified fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a "neptune" "cluster" configuration is modified
    Then the operation is rejected
