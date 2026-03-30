@elasticache @generated
Feature: Elasticache - A Cache Cluster Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cache_cluster_deletion @internal
  Scenario: a cache cluster deletion completes
    Given the cluster exists
    And the cluster is "DELETING"
    When a cache cluster deletion completes
    Then the cluster is "DELETED" and its tags are removed
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_cache_cluster_deletion @internal
  Scenario: a cache cluster deletion completes fails when the cluster does not exist
    Given the cluster does not exist
    When a cache cluster deletion completes
    Then the operation is rejected

  @guard @negative @complete_cache_cluster_deletion @internal
  Scenario: a cache cluster deletion completes fails when the cluster is not "DELETING"
    Given the cluster exists
    And the cluster is not "DELETING"
    When a cache cluster deletion completes
    Then the operation is rejected
