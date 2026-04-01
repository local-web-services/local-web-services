@neptune @generated
Feature: Neptune - A Stopped "Neptune" "Cluster" Is Started

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @start_d_b_cluster
  Scenario: a stopped "neptune" "cluster" is started
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "STOPPED"
    When a stopped "neptune" "cluster" is started
    Then the "neptune" "cluster" will be in "STARTING" state
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @start_d_b_cluster
  Scenario: a stopped "neptune" "cluster" is started fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a stopped "neptune" "cluster" is started
    Then the operation is rejected

  @guard @negative @start_d_b_cluster @lifecycle
  Scenario: a stopped "neptune" "cluster" is started fails when the "neptune" "cluster" was not "STOPPED"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "STOPPED"
    When a stopped "neptune" "cluster" is started
    Then the operation is rejected
