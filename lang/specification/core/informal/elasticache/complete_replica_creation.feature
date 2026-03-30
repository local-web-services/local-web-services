@elasticache @generated
Feature: Elasticache - A Replica Creation In A Replication Group Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replica_creation @internal
  Scenario: a replica creation in a replication group completes
    Given the cluster exists
    And the cluster is "CREATING"
    And the cluster is part of a replication group
    When a replica creation in a replication group completes
    Then the replica cluster is "AVAILABLE"
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a replication group completes fails when the cluster does not exist
    Given the cluster does not exist
    When a replica creation in a replication group completes
    Then the operation is rejected

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a replication group completes fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a replica creation in a replication group completes
    Then the operation is rejected

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a replication group completes fails when the cluster is not part of a replication group
    Given the cluster exists
    And the cluster is "CREATING"
    And the cluster is not part of a replication group
    When a replica creation in a replication group completes
    Then the operation is rejected
