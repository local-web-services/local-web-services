@elasticache @generated
Feature: Elasticache - A Cache Cluster Is Created From A Snapshot

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_cluster_from_snapshot
  Scenario: a cache cluster is created from a snapshot
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is available
    When a cache cluster is created from a snapshot
    Then the cluster is in "RESTORING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @create_cache_cluster_from_snapshot
  Scenario: a cache cluster is created from a snapshot fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cache cluster is created from a snapshot
    Then the operation is rejected

  @standard @negative @create_cache_cluster_from_snapshot @lifecycle @internal
  Scenario: a cache cluster is created from a snapshot fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a cache cluster is created from a snapshot
    Then the operation is rejected

  @standard @negative @create_cache_cluster_from_snapshot
  Scenario: a cache cluster is created from a snapshot fails when the target cluster slot is not available
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    And the target cluster slot is not available
    When a cache cluster is created from a snapshot
    Then the operation is rejected
