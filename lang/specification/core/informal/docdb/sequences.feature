@docdb @generated
Feature: Docdb - Action Sequences

  # Generated from FizzBee spec: docdb.fizz
  # Safety invariants: ValidClusterStatus, ValidInstanceStatus, ValidSnapshotStatus, NoNonDeletedInstancesOnDeletedCluster, NoAvailableInstancesOnFailedCluster, DeletingClusterGetsNoNewInstances, SnapshotHasValidClusterReference

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster creation fails
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster configuration is modified
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster modification completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance is created in an available cluster
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance configuration is modified
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance modification completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot is created
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a cluster is restored from a snapshot
    Given cid not in cluster_status
    Given a database cluster has been created
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a database cluster has been created
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a failover is triggered and a replica is promoted to primary
    Given cid not in cluster_status
    Given a database cluster has been created
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster is created
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster is created
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster creation has failed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster is created
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster is created
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster modification has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster is created
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster is created
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster is created
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster creation fails
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster modification completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance configuration is modified
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance modification completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster is created
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster creation fails
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance has finished creating
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster creation fails
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance configuration has been modified
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster is created
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster creation fails
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster modification completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance modification has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance modification has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster is created
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster creation fails
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster modification completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster is deleted
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster is created
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster creation fails
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster is created
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster is created
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster creation fails
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster modification completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance configuration is modified
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance modification completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster is created
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster is created
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster creation fails
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster configuration is modified
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster modification completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance configuration is modified
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance modification completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot is created
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster finishes creating then a database cluster creation fails
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster creation fails then a database cluster configuration is modified
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster creation has failed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster configuration is modified then a database cluster modification completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster configuration has been modified
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster modification completes then a database cluster is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster modification has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster is deleted then a database cluster deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster deletion completes then a database instance is created in an available cluster
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance is created in an available cluster then a database instance finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance has been created in an available cluster
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance finishes creating then a database instance configuration is modified
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance configuration is modified then a database instance modification completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance modification completes then a database instance is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance modification has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance is deleted then a database instance deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance has been deleted
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database instance deletion completes then a database cluster snapshot is created
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database instance deletion has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot is created then a database cluster snapshot finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster snapshot has been created
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot finishes creating then a database cluster snapshot is deleted
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot is deleted then a database cluster snapshot deletion completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster snapshot deletion completes then a cluster is restored from a snapshot
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster snapshot deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a cluster is restored from a snapshot then a database cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a cluster has been restored from a snapshot
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a database cluster restore from snapshot completes then a failover is triggered and a replica is promoted to primary
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a database cluster restore from snapshot has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is created then a failover is triggered and a replica is promoted to primary then a database cluster finishes creating
    Given cid not in cluster_status
    Given a database cluster has been created
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster is created then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster has been created
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster creation fails then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster creation has failed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster configuration is modified then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster configuration has been modified
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster modification completes then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster modification has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster is deleted then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster deletion completes then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance is created in an available cluster then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance has been created in an available cluster
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance finishes creating then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance configuration is modified then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance configuration has been modified
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance modification completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance modification has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance is deleted then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database instance deletion completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database instance deletion has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot is created then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster snapshot has been created
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot finishes creating then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot is deleted then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster snapshot has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster snapshot deletion completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster snapshot deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a cluster is restored from a snapshot then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a cluster has been restored from a snapshot
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a database cluster restore from snapshot completes then a database cluster is created
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a database cluster restore from snapshot has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster finishes creating then a failover is triggered and a replica is promoted to primary then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster has finished creating
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster is created then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster has been created
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster finishes creating then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster configuration is modified then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster configuration has been modified
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster modification completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster modification has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster is deleted then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster deletion completes then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance is created in an available cluster then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance has been created in an available cluster
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance finishes creating then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance configuration is modified then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance configuration has been modified
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance modification completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance modification has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance is deleted then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database instance deletion completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database instance deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot is created then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster snapshot has been created
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot finishes creating then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster snapshot has finished creating
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot is deleted then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster snapshot has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster snapshot deletion completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster snapshot deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a cluster is restored from a snapshot then a database cluster is created
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a cluster has been restored from a snapshot
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a database cluster restore from snapshot completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a database cluster restore from snapshot has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster creation fails then a failover is triggered and a replica is promoted to primary then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster creation has failed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster is created then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster has been created
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster finishes creating then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster creation fails then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster creation has failed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster modification completes then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster modification has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster is deleted then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster deletion completes then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance is created in an available cluster then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance has been created in an available cluster
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance finishes creating then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance configuration is modified then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance configuration has been modified
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance modification completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance modification has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance is deleted then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance has been deleted
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database instance deletion completes then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database instance deletion has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot is created then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster snapshot has been created
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot finishes creating then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster snapshot has finished creating
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot is deleted then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster snapshot has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster snapshot deletion completes then a database cluster is created
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster snapshot deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a cluster is restored from a snapshot then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a cluster has been restored from a snapshot
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a database cluster restore from snapshot completes then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a database cluster restore from snapshot has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster configuration is modified then a failover is triggered and a replica is promoted to primary then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster configuration has been modified
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster is created then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster has been created
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster finishes creating then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster creation fails then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster creation has failed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster configuration is modified then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster configuration has been modified
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster is deleted then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster deletion completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance is created in an available cluster then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance has been created in an available cluster
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance finishes creating then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance configuration is modified then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance configuration has been modified
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance modification completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance modification has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance is deleted then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database instance deletion completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database instance deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot is created then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster snapshot has been created
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot finishes creating then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster snapshot has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot is deleted then a database cluster is created
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster snapshot has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster snapshot deletion completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster snapshot deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a cluster is restored from a snapshot then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a cluster has been restored from a snapshot
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a database cluster restore from snapshot completes then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a database cluster restore from snapshot has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster modification completes then a failover is triggered and a replica is promoted to primary then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster modification has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster is created then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster has been created
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster finishes creating then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster has finished creating
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster creation fails then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster creation has failed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster configuration is modified then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster configuration has been modified
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster modification completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster modification has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster deletion completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster deletion has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance is created in an available cluster then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance has been created in an available cluster
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance finishes creating then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance has finished creating
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance configuration is modified then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance configuration has been modified
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance modification completes then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance modification has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance is deleted then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database instance deletion completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database instance deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot is created then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster snapshot has been created
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot finishes creating then a database cluster is created
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster snapshot has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot is deleted then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster snapshot has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster snapshot deletion completes then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster snapshot deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a cluster is restored from a snapshot then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a cluster has been restored from a snapshot
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a database cluster restore from snapshot completes then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a database cluster restore from snapshot has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster is deleted then a failover is triggered and a replica is promoted to primary then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster has been deleted
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster is created then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster has been created
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster finishes creating then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster creation fails then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster creation has failed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster configuration is modified then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster configuration has been modified
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster modification completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster modification has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster is deleted then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance is created in an available cluster then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance has been created in an available cluster
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance finishes creating then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance configuration is modified then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance configuration has been modified
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance modification completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance modification has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance is deleted then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database instance deletion completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database instance deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot is created then a database cluster is created
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster snapshot has been created
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot finishes creating then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster snapshot has finished creating
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot is deleted then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster snapshot has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster snapshot deletion completes then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster snapshot deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a cluster is restored from a snapshot then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a cluster has been restored from a snapshot
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a database cluster restore from snapshot completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a database cluster restore from snapshot has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster deletion completes then a failover is triggered and a replica is promoted to primary then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster deletion has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster is created then a database instance configuration is modified
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster has been created
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster finishes creating then a database instance modification completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster creation fails then a database instance is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster creation has failed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster configuration is modified then a database instance deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster configuration has been modified
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster modification completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster modification has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster is deleted then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster deletion completes then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance finishes creating then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database instance has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance configuration is modified then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database instance configuration has been modified
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance modification completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database instance modification has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance is deleted then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database instance has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database instance deletion completes then a database cluster is created
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database instance deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot is created then a database cluster finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster snapshot has been created
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot finishes creating then a database cluster creation fails
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster snapshot has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot is deleted then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster snapshot has been deleted
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster snapshot deletion completes then a database cluster modification completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster snapshot deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a cluster is restored from a snapshot then a database cluster is deleted
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a cluster has been restored from a snapshot
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a database cluster restore from snapshot completes then a database cluster deletion completes
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a database cluster restore from snapshot has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is created in an available cluster then a failover is triggered and a replica is promoted to primary then a database instance finishes creating
    Given cid in cluster_status
    Given a database instance has been created in an available cluster
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster is created then a database instance modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster has been created
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster finishes creating then a database instance is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster creation fails then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster creation has failed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster configuration is modified then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster configuration has been modified
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster modification completes then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster modification has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster is deleted then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster has been deleted
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster deletion completes then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster deletion has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance is created in an available cluster then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been created in an available cluster
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance configuration is modified then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance configuration has been modified
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance modification completes then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance modification has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance is deleted then a database cluster is created
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database instance deletion completes then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database instance deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot is created then a database cluster creation fails
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster snapshot has been created
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot finishes creating then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster snapshot has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot is deleted then a database cluster modification completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster snapshot has been deleted
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster snapshot deletion completes then a database cluster is deleted
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster snapshot deletion has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a cluster is restored from a snapshot then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance has finished creating
    Given a cluster has been restored from a snapshot
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a database cluster restore from snapshot completes then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance has finished creating
    Given a database cluster restore from snapshot has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance finishes creating then a failover is triggered and a replica is promoted to primary then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has finished creating
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster is created then a database instance is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster has been created
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster finishes creating then a database instance deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster creation fails then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster creation has failed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster configuration is modified then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster configuration has been modified
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster modification completes then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster modification has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster is deleted then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster deletion completes then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance is created in an available cluster then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been created in an available cluster
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance finishes creating then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance modification completes then a database cluster is created
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance modification has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance is deleted then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database instance deletion completes then a database cluster creation fails
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database instance deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot is created then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster snapshot has been created
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot finishes creating then a database cluster modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster snapshot has finished creating
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot is deleted then a database cluster is deleted
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster snapshot has been deleted
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster snapshot deletion completes then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster snapshot deletion has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a cluster is restored from a snapshot then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a cluster has been restored from a snapshot
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a database cluster restore from snapshot completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a database cluster restore from snapshot has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance configuration is modified then a failover is triggered and a replica is promoted to primary then a database instance modification completes
    Given iid in instance_status
    Given a database instance configuration has been modified
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster is created then a database instance deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster has been created
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster finishes creating then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster creation fails then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster creation has failed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster configuration is modified then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster configuration has been modified
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster modification completes then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster modification has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster is deleted then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster deletion completes then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance is created in an available cluster then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been created in an available cluster
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance finishes creating then a database cluster is created
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance configuration is modified then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance configuration has been modified
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance is deleted then a database cluster creation fails
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database instance deletion completes then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database instance deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot is created then a database cluster modification completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster snapshot has been created
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot finishes creating then a database cluster is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster snapshot has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot is deleted then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster snapshot has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster snapshot deletion completes then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster snapshot deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a cluster is restored from a snapshot then a database instance finishes creating
    Given iid in instance_status
    Given a database instance modification has completed
    Given a cluster has been restored from a snapshot
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a database cluster restore from snapshot completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance modification has completed
    Given a database cluster restore from snapshot has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance modification completes then a failover is triggered and a replica is promoted to primary then a database instance is deleted
    Given iid in instance_status
    Given a database instance modification has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster is created then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster has been created
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster finishes creating then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster has finished creating
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster creation fails then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster creation has failed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster configuration is modified then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster configuration has been modified
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster modification completes then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster modification has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster is deleted then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster has been deleted
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster deletion completes then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster deletion has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance is created in an available cluster then a database cluster is created
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database instance has been created in an available cluster
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance finishes creating then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database instance has finished creating
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance configuration is modified then a database cluster creation fails
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database instance configuration has been modified
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance modification completes then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database instance modification has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database instance deletion completes then a database cluster modification completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database instance deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot is created then a database cluster is deleted
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster snapshot has been created
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot finishes creating then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster snapshot has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot is deleted then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster snapshot has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster snapshot deletion completes then a database instance finishes creating
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster snapshot deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a cluster is restored from a snapshot then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance has been deleted
    Given a cluster has been restored from a snapshot
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a database cluster restore from snapshot completes then a database instance modification completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a database cluster restore from snapshot has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance is deleted then a failover is triggered and a replica is promoted to primary then a database instance deletion completes
    Given iid in instance_status
    Given a database instance has been deleted
    Given a failover has been triggered and a replica has been promoted to primary
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster is created then a database cluster snapshot finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster has been created
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster finishes creating then a database cluster snapshot is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster creation fails then a database cluster snapshot deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster creation has failed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster configuration is modified then a cluster is restored from a snapshot
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster configuration has been modified
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster modification completes then a database cluster restore from snapshot completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster modification has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster is deleted then a failover is triggered and a replica is promoted to primary
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster has been deleted
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster deletion completes then a database cluster is created
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster deletion has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance is created in an available cluster then a database cluster finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been created in an available cluster
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance finishes creating then a database cluster creation fails
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance configuration is modified then a database cluster configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance configuration has been modified
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance modification completes then a database cluster modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance modification has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database instance is deleted then a database cluster is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database instance has been deleted
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot is created then a database cluster deletion completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster snapshot has been created
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot finishes creating then a database instance is created in an available cluster
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster snapshot has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot is deleted then a database instance finishes creating
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster snapshot has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster snapshot deletion completes then a database instance configuration is modified
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster snapshot deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a cluster is restored from a snapshot then a database instance modification completes
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a cluster has been restored from a snapshot
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a database cluster restore from snapshot completes then a database instance is deleted
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a database cluster restore from snapshot has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database instance deletion completes then a failover is triggered and a replica is promoted to primary then a database cluster snapshot is created
    Given iid in instance_status
    Given a database instance deletion has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster is created then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster has been created
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster finishes creating then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster creation fails then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster creation has failed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster configuration is modified then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster configuration has been modified
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster modification completes then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster modification has completed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster is deleted then a database cluster is created
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster has been deleted
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster deletion completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster deletion has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance is created in an available cluster then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance has been created in an available cluster
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance finishes creating then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance configuration is modified then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance configuration has been modified
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance modification completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance modification has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance is deleted then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database instance deletion completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database instance deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot finishes creating then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster snapshot has finished creating
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot is deleted then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster snapshot has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster snapshot deletion completes then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster snapshot deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a cluster is restored from a snapshot then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a cluster has been restored from a snapshot
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a database cluster restore from snapshot completes then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a database cluster restore from snapshot has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is created then a failover is triggered and a replica is promoted to primary then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster snapshot has been created
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster is created then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster has been created
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster finishes creating then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster has finished creating
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster creation fails then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster creation has failed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster configuration is modified then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster configuration has been modified
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster modification completes then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster modification has completed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster is deleted then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster has been deleted
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster deletion completes then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster deletion has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance is created in an available cluster then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance has been created in an available cluster
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance finishes creating then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance has finished creating
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance configuration is modified then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance configuration has been modified
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance modification completes then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance modification has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance is deleted then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database instance deletion completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database instance deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot is created then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster snapshot has been created
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot is deleted then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster snapshot has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster snapshot deletion completes then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster snapshot deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a cluster is restored from a snapshot then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a cluster has been restored from a snapshot
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a database cluster restore from snapshot completes then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot finishes creating then a failover is triggered and a replica is promoted to primary then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has finished creating
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster is created then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster has been created
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster finishes creating then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster has finished creating
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster creation fails then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster creation has failed
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster configuration is modified then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster configuration has been modified
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster modification completes then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster modification has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster is deleted then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster has been deleted
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster deletion completes then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster deletion has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance is created in an available cluster then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance has been created in an available cluster
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance finishes creating then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance has finished creating
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance configuration is modified then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance configuration has been modified
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance modification completes then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance modification has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance is deleted then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance has been deleted
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database instance deletion completes then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database instance deletion has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot is created then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster snapshot has been created
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot finishes creating then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster snapshot has finished creating
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster snapshot deletion completes then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster snapshot deletion has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a cluster is restored from a snapshot then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a database cluster restore from snapshot completes then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot is deleted then a failover is triggered and a replica is promoted to primary then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot has been deleted
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster is created then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster has been created
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster finishes creating then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster has finished creating
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster creation fails then a database cluster is created
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster creation has failed
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster configuration is modified then a database cluster finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster configuration has been modified
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster modification completes then a database cluster creation fails
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster modification has completed
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster is deleted then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster has been deleted
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster deletion completes then a database cluster modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster deletion has completed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance is created in an available cluster then a database cluster is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance has been created in an available cluster
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance finishes creating then a database cluster deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance has finished creating
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance configuration is modified then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance configuration has been modified
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance modification completes then a database instance finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance modification has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance is deleted then a database instance configuration is modified
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance has been deleted
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database instance deletion completes then a database instance modification completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database instance deletion has completed
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot is created then a database instance is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster snapshot has been created
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot finishes creating then a database instance deletion completes
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster snapshot has finished creating
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster snapshot is deleted then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a cluster is restored from a snapshot then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a cluster has been restored from a snapshot
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a database cluster restore from snapshot completes then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster snapshot deletion completes then a failover is triggered and a replica is promoted to primary then a cluster is restored from a snapshot
    Given sid in snapshot_status
    Given a database cluster snapshot deletion has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster is created then a failover is triggered and a replica is promoted to primary
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster has been created
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster finishes creating then a database cluster is created
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster has finished creating
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster creation fails then a database cluster finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster creation has failed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster configuration is modified then a database cluster creation fails
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster configuration has been modified
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster modification completes then a database cluster configuration is modified
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster modification has completed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster is deleted then a database cluster modification completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster has been deleted
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster deletion completes then a database cluster is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster deletion has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance is created in an available cluster then a database cluster deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance has been created in an available cluster
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance finishes creating then a database instance is created in an available cluster
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance has finished creating
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance configuration is modified then a database instance finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance configuration has been modified
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance modification completes then a database instance configuration is modified
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance modification has completed
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance is deleted then a database instance modification completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance has been deleted
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database instance deletion completes then a database instance is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database instance deletion has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot is created then a database instance deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster snapshot has been created
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot finishes creating then a database cluster snapshot is created
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot is deleted then a database cluster snapshot finishes creating
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster snapshot deletion completes then a database cluster snapshot is deleted
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster snapshot deletion has completed
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a database cluster restore from snapshot completes then a database cluster snapshot deletion completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a database cluster restore from snapshot has completed
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a cluster is restored from a snapshot then a failover is triggered and a replica is promoted to primary then a database cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cluster has been restored from a snapshot
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster is created then a database cluster finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster has been created
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster finishes creating then a database cluster creation fails
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster has finished creating
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster creation fails then a database cluster configuration is modified
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster creation has failed
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster configuration is modified then a database cluster modification completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster configuration has been modified
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster modification completes then a database cluster is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster modification has completed
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster is deleted then a database cluster deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster has been deleted
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster deletion completes then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster deletion has completed
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance is created in an available cluster then a database instance finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance has been created in an available cluster
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance finishes creating then a database instance configuration is modified
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance has finished creating
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance configuration is modified then a database instance modification completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance configuration has been modified
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance modification completes then a database instance is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance modification has completed
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance is deleted then a database instance deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance has been deleted
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database instance deletion completes then a database cluster snapshot is created
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database instance deletion has completed
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot is created then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster snapshot has been created
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot finishes creating then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot is deleted then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster snapshot has been deleted
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a database cluster snapshot deletion completes then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a database cluster snapshot deletion has completed
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a cluster is restored from a snapshot then a failover is triggered and a replica is promoted to primary
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a cluster has been restored from a snapshot
    When a failover is triggered and a replica is promoted to primary
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a database cluster restore from snapshot completes then a failover is triggered and a replica is promoted to primary then a database cluster is created
    Given cid in cluster_status
    Given a database cluster restore from snapshot has completed
    Given a failover has been triggered and a replica has been promoted to primary
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster is created then a database cluster creation fails
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster has been created
    When a database cluster creation fails
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster finishes creating then a database cluster configuration is modified
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster has finished creating
    When a database cluster configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster creation fails then a database cluster modification completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster creation has failed
    When a database cluster modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster configuration is modified then a database cluster is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster configuration has been modified
    When a database cluster is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster modification completes then a database cluster deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster modification has completed
    When a database cluster deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster is deleted then a database instance is created in an available cluster
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster has been deleted
    When a database instance is created in an available cluster
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster deletion completes then a database instance finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster deletion has completed
    When a database instance finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance is created in an available cluster then a database instance configuration is modified
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance has been created in an available cluster
    When a database instance configuration is modified
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance finishes creating then a database instance modification completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance has finished creating
    When a database instance modification completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance configuration is modified then a database instance is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance configuration has been modified
    When a database instance is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance modification completes then a database instance deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance modification has completed
    When a database instance deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance is deleted then a database cluster snapshot is created
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance has been deleted
    When a database cluster snapshot is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database instance deletion completes then a database cluster snapshot finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database instance deletion has completed
    When a database cluster snapshot finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot is created then a database cluster snapshot is deleted
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster snapshot has been created
    When a database cluster snapshot is deleted
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot finishes creating then a database cluster snapshot deletion completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster snapshot has finished creating
    When a database cluster snapshot deletion completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot is deleted then a cluster is restored from a snapshot
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster snapshot has been deleted
    When a cluster is restored from a snapshot
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster snapshot deletion completes then a database cluster restore from snapshot completes
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster snapshot deletion has completed
    When a database cluster restore from snapshot completes
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a cluster is restored from a snapshot then a database cluster is created
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a cluster has been restored from a snapshot
    When a database cluster is created
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted

  @exhaustive @sequence
  Scenario: a failover is triggered and a replica is promoted to primary then a database cluster restore from snapshot completes then a database cluster finishes creating
    Given cid in cluster_status
    Given a failover has been triggered and a replica has been promoted to primary
    Given a database cluster restore from snapshot has completed
    When a database cluster finishes creating
    Then every cluster has a valid status
    And every instance has a valid status
    And every snapshot has a valid status
    And a deleted cluster has no non-deleted instances
    And a failed cluster has no available instances
    And a deleting cluster receives no new instances
    And every creating snapshot references a cluster that has not been deleted
