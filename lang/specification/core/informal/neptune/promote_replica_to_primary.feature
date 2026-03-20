@neptune @generated
Feature: Neptune - A Replica Instance Is Promoted To Primary During Failover

  # Generated from FizzBee spec: neptune.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, StoppedClusterHasNoAvailableInstances, StoppedClusterInstancesNotModifiable, NoAvailableInstancesOnDeletedCluster, BackingUpClusterHasSnapshot, NoAvailableInstancesOnFailedCluster

  Background:
    Given the system is initialized

  @minimal @happy @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover
    Given the cluster exists
    And the cluster is "MODIFYING"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is not already the primary
    And the instance is "AVAILABLE"
    When a replica instance is promoted to primary during failover
    Then the cluster returns to "AVAILABLE" with a new primary instance
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a stopped cluster has no available instances
    And instances on a stopped or stopping cluster are not in "MODIFYING" state
    And a deleted cluster has no available instances
    And every backing-up cluster has a corresponding in-progress snapshot
    And a failed cluster has no available instances

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the cluster does not exist
    Given the cluster does not exist
    When a replica instance is promoted to primary during failover
    Then the operation is rejected

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the cluster is not "MODIFYING"
    Given the cluster exists
    And the cluster is not "MODIFYING"
    When a replica instance is promoted to primary during failover
    Then the operation is rejected

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the new primary instance does not exist
    Given the cluster exists
    And the cluster is "MODIFYING"
    And the new primary instance does not exist
    When a replica instance is promoted to primary during failover
    Then the operation is rejected

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the instance does not belong to this cluster
    Given the cluster exists
    And the cluster is "MODIFYING"
    And the new primary instance exists
    And the instance does not belong to this cluster
    When a replica instance is promoted to primary during failover
    Then the operation is rejected

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the instance is already the primary
    Given the cluster exists
    And the cluster is "MODIFYING"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is already the primary
    When a replica instance is promoted to primary during failover
    Then the operation is rejected

  @standard @negative @promote_replica_to_primary @internal
  Scenario: a replica instance is promoted to primary during failover fails when the instance is not "AVAILABLE"
    Given the cluster exists
    And the cluster is "MODIFYING"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is not already the primary
    And the instance is not "AVAILABLE"
    When a replica instance is promoted to primary during failover
    Then the operation is rejected
