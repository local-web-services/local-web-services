@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Start Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_start @internal
  Scenario: a "neptune" "cluster" start completes
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "STARTING"
    When a "neptune" "cluster" start completes
    Then the "neptune" "cluster" and its instances are "AVAILABLE"
    And every "neptune" "cluster" has a valid status
    And every "neptune" "instance" has a valid status
    And every "neptune" "snapshot" has a valid status
    And a stopped "neptune" "cluster" has no available "neptune" "instance"s
    And "neptune" "instance"s on a stopped or stopping "neptune" "cluster" are not in "MODIFYING" state
    And a deleted "neptune" "cluster" has no available "neptune" "instance"s
    And every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"
    And a failed "neptune" "cluster" has no available "neptune" "instance"s

  @guard @negative @complete_cluster_start @internal
  Scenario: a "neptune" "cluster" start completes fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" start completes
    Then the operation is rejected

  @guard @negative @complete_cluster_start @internal
  Scenario: a "neptune" "cluster" start completes fails when the "neptune" "cluster" was not "STARTING"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "STARTING"
    When a "neptune" "cluster" start completes
    Then the operation is rejected
