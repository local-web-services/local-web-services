@neptune @generated
Feature: Neptune - A Multi-Az Failover Is Triggered On A "Neptune" "Cluster"

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a "neptune" "cluster"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And multi-"AZ" was "ENABLED" for the "neptune" "cluster"
    When a multi-"AZ" failover is triggered on a "neptune" "cluster"
    Then the "neptune" "cluster" will be in "MODIFYING" state for primary promotion
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @guard @negative @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a "neptune" "cluster" fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When a multi-"AZ" failover is triggered on a "neptune" "cluster"
    Then the operation is rejected

  @guard @negative @multi_a_z_failover @lifecycle
  Scenario: a multi-"AZ" failover is triggered on a "neptune" "cluster" fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When a multi-"AZ" failover is triggered on a "neptune" "cluster"
    Then the operation is rejected

  @guard @negative @multi_a_z_failover
  Scenario: a multi-"AZ" failover is triggered on a "neptune" "cluster" fails when multi-"AZ" was not "ENABLED" for the "neptune" "cluster"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    And multi-"AZ" was not "ENABLED" for the "neptune" "cluster"
    When a multi-"AZ" failover is triggered on a "neptune" "cluster"
    Then the operation is rejected
