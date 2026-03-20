@neptune @generated
Feature: Neptune - A Database Cluster Restore From Snapshot Completes

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes
    Given the cluster exists
    And the cluster is "RESTORING"
    When a database cluster restore from snapshot completes
    Then the cluster is "AVAILABLE"
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @standard @negative @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes fails when the cluster does not exist
    Given the cluster does not exist
    When a database cluster restore from snapshot completes
    Then the operation is rejected

  @standard @negative @complete_cluster_restore @internal
  Scenario: a database cluster restore from snapshot completes fails when the cluster is not "RESTORING"
    Given the cluster exists
    And the cluster is not "RESTORING"
    When a database cluster restore from snapshot completes
    Then the operation is rejected
