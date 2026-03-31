@elasticache @generated
Feature: Elasticache - A Memcached "Elasticache" "Cluster" Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_memcached_cache_cluster
  Scenario: a memcached "elasticache" "cluster" is created
    Given the "elasticache" "cluster" did not already exist
    When a memcached "elasticache" "cluster" is created
    Then the "elasticache" "cluster" will be in "CREATING" state with the memcached engine
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @create_memcached_cache_cluster
  Scenario: a memcached "elasticache" "cluster" is created fails when the "elasticache" "cluster" already existed
    Given the "elasticache" "cluster" already existed
    When a memcached "elasticache" "cluster" is created
    Then the operation is rejected
