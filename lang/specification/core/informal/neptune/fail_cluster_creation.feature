@neptune @generated
Feature: Neptune - A "Neptune" "Cluster" Creation Fails

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @fail_cluster_creation @internal
  Scenario: a "neptune" "cluster" creation fails
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "CREATING"
    When a "neptune" "cluster" creation fails
    Then the "neptune" "cluster" will be in "FAILED" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @fail_cluster_creation @internal
  Scenario: a "neptune" "cluster" creation fails fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a "neptune" "cluster" creation fails
    Then the operation is rejected

  @guard @negative @fail_cluster_creation @internal
  Scenario: a "neptune" "cluster" creation fails fails when the "neptune" "cluster" was not "CREATING"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "CREATING"
    When a "neptune" "cluster" creation fails
    Then the operation is rejected
