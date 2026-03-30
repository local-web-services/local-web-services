@neptune @generated
Feature: Neptune - A Database Cluster Is Created

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @create_d_b_cluster
  Scenario: a database cluster is created
    Given the cluster does not already exist
    When a database cluster is created
    Then the cluster is in "CREATING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @create_d_b_cluster
  Scenario: a database cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a database cluster is created
    Then the operation is rejected
