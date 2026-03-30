@elasticache @generated
Feature: Elasticache - A Cache Cluster Configuration Is Modified

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_cache_cluster
  Scenario: a cache cluster configuration is modified
    Given the cluster exists
    And the cluster is "AVAILABLE"
    When a cache cluster configuration is modified
    Then the cluster is in "MODIFYING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @modify_cache_cluster
  Scenario: a cache cluster configuration is modified fails when the cluster does not exist
    Given the cluster does not exist
    When a cache cluster configuration is modified
    Then the operation is rejected

  @guard @negative @modify_cache_cluster @lifecycle
  Scenario: a cache cluster configuration is modified fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a cache cluster configuration is modified
    Then the operation is rejected
