@neptune @generated
Feature: Neptune - A Database Cluster Creation Fails

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @fail_cluster_creation @internal
  Scenario: a database cluster creation fails
    Given the cluster exists
    And the cluster is "CREATING"
    When a database cluster creation fails
    Then the cluster is in "FAILED" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @fail_cluster_creation @internal
  Scenario: a database cluster creation fails fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster creation fails
    Then the operation is rejected

  @guard @negative @fail_cluster_creation @internal
  Scenario: a database cluster creation fails fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a database cluster creation fails
    Then the operation is rejected
