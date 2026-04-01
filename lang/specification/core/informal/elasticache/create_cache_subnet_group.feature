@elasticache @generated
Feature: Elasticache - An "Elasticache" Subnet Group Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_subnet_group
  Scenario: an "elasticache" subnet group is created
    Given the "elasticache" subnet group did not already exist
    When an "elasticache" subnet group is created
    Then the "elasticache" subnet group will exist
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @create_cache_subnet_group
  Scenario: an "elasticache" subnet group is created fails when the "elasticache" subnet group already existed
    Given the "elasticache" subnet group already existed
    When an "elasticache" subnet group is created
    Then the operation is rejected
