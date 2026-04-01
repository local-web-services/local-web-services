@elasticache @generated
Feature: Elasticache - An "Elasticache" Subnet Group Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_cache_subnet_group
  Scenario: an "elasticache" subnet group is deleted
    Given the "elasticache" subnet group existed
    And the "elasticache" subnet group was present
    When an "elasticache" subnet group is deleted
    Then the "elasticache" subnet group no longer will exist
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @delete_cache_subnet_group
  Scenario: an "elasticache" subnet group is deleted fails when the "elasticache" subnet group did not exist
    Given the "elasticache" subnet group did not exist
    When an "elasticache" subnet group is deleted
    Then the operation is rejected

  @guard @negative @delete_cache_subnet_group
  Scenario: an "elasticache" subnet group is deleted fails when the "elasticache" subnet group was not present
    Given the "elasticache" subnet group existed
    And the "elasticache" subnet group was not present
    When an "elasticache" subnet group is deleted
    Then the operation is rejected
