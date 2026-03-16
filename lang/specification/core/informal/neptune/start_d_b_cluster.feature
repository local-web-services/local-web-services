@neptune @generated
Feature: Neptune - A Stopped Database Cluster Is Started

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @start_d_b_cluster
  Scenario: a stopped database cluster is started
    Given the cluster exists
    And the cluster is "STOPPED"
    When a stopped database cluster is started
    Then the cluster is in "STARTING" state
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And a failed cluster has no available instances

  @standard @negative @start_d_b_cluster
  Scenario: a stopped database cluster is started fails when the cluster does not exist
    Given the cluster does not exist
    When a stopped database cluster is started
    Then the operation is rejected

  @standard @negative @start_d_b_cluster @lifecycle
  Scenario: a stopped database cluster is started fails when the cluster is not "STOPPED"
    Given the cluster exists
    And the cluster is not "STOPPED"
    When a stopped database cluster is started
    Then the operation is rejected
