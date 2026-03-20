@neptune @generated
Feature: Neptune - A Multi-Az Failover Is Triggered On A Cluster

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And multi-"AZ" is enabled for the cluster
    When a multi-"AZ" failover is triggered on a cluster
    Then the cluster enters "MODIFYING" state for primary promotion
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @standard @negative @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a cluster fails when the cluster does not exist
    Given the cluster does not exist
    When a multi-"AZ" failover is triggered on a cluster
    Then the operation is rejected

  @standard @negative @multi_a_z_failover @lifecycle
  Scenario: a multi-"AZ" failover is triggered on a cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a multi-"AZ" failover is triggered on a cluster
    Then the operation is rejected

  @standard @negative @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a cluster fails when multi-"AZ" is not enabled for the cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And multi-"AZ" is not enabled for the cluster
    When a multi-"AZ" failover is triggered on a cluster
    Then the operation is rejected
