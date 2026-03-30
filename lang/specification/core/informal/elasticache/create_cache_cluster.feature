@elasticache @generated
Feature: Elasticache - A Redis Cache Cluster Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_cluster
  Scenario: a redis cache cluster is created
    Given the cluster does not already exist
    When a redis cache cluster is created
    Then the cluster is in "CREATING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @create_cache_cluster
  Scenario: a redis cache cluster is created fails when the cluster already exists
    Given the cluster already exists
    When a redis cache cluster is created
    Then the operation is rejected
