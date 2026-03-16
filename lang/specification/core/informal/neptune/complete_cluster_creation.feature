@neptune @generated
Feature: Neptune - A Database Cluster Finishes Creating

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_creation @internal
  Scenario: a database cluster finishes creating
    Given the cluster exists
    And the cluster is "CREATING"
    When a database cluster finishes creating
    Then the cluster is "AVAILABLE"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

  @standard @negative @complete_cluster_creation @internal
  Scenario: a database cluster finishes creating fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster finishes creating
    Then the operation is rejected

  @standard @negative @complete_cluster_creation @internal
  Scenario: a database cluster finishes creating fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a database cluster finishes creating
    Then the operation is rejected
