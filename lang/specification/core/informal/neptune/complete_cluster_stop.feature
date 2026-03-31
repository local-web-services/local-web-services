@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Stop Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_stop @internal
  Scenario: a "neptune" "cluster" stop completes
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "STOPPING"
    When a "neptune" "cluster" stop completes
    Then the "neptune" "cluster" and its instances are "STOPPED"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @complete_cluster_stop @internal
  Scenario: a "neptune" "cluster" stop completes fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" stop completes
    Then the operation is rejected

  @guard @negative @complete_cluster_stop @internal
  Scenario: a "neptune" "cluster" stop completes fails when the "neptune" "cluster" was not "STOPPING"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "STOPPING"
    When a "neptune" "cluster" stop completes
    Then the operation is rejected
