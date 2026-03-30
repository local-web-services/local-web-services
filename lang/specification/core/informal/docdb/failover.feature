@docdb @generated
Feature: Docdb - A Failover Is Triggered And A Replica Is Promoted To Primary

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @minimal @happy @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is not already the primary
    And the instance is "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the cluster has a new primary instance
    And every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the cluster does not exist
    Given the cluster does not exist
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the new primary instance does not exist
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the new primary instance does not exist
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the instance does not belong to this cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the new primary instance exists
    And the instance does not belong to this cluster
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the instance is already the primary
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is already the primary
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected

  @guard @negative @failover @internal
  Scenario: a failover is triggered and a replica is promoted to primary fails when the instance is not "AVAILABLE"
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the new primary instance exists
    And the instance belongs to this cluster
    And the instance is not already the primary
    And the instance is not "AVAILABLE"
    When a failover is triggered and a replica is promoted to primary
    Then the operation is rejected
