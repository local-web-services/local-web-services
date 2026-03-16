@neptune @generated
Feature: Neptune - A Database Cluster Configuration Is Modified

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @modify_d_b_cluster
  Scenario: a database cluster configuration is modified
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a database cluster configuration is modified
    Then the cluster is in "MODIFYING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

  @standard @negative @modify_d_b_cluster
  Scenario: a database cluster configuration is modified fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster configuration is modified
    Then the operation is rejected

  @standard @negative @modify_d_b_cluster @lifecycle
  Scenario: a database cluster configuration is modified fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a database cluster configuration is modified
    Then the operation is rejected
