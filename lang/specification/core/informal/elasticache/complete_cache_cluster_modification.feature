@elasticache @generated
Feature: Elasticache - A Cache Cluster Modification Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cache_cluster_modification @internal
  Scenario: a cache cluster modification completes
    Given the cluster exists
    And the cluster is "MODIFYING"
    When a cache cluster modification completes
    Then the cluster returns to "AVAILABLE" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_cache_cluster_modification @internal
  Scenario: a cache cluster modification completes fails when the cluster does not exist
    Given the cluster does not exist
    When a cache cluster modification completes
    Then the operation is rejected

  @standard @negative @complete_cache_cluster_modification @internal
  Scenario: a cache cluster modification completes fails when the cluster is not "MODIFYING"
    Given the cluster exists
    And the cluster is not "MODIFYING"
    When a cache cluster modification completes
    Then the operation is rejected
