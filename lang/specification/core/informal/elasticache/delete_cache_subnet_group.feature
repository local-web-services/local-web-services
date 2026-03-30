@elasticache @generated
Feature: Elasticache - A Cache Subnet Group Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_cache_subnet_group
  Scenario: a cache subnet group is deleted
    Given the subnet group exists
    And the subnet group is present
    When a cache subnet group is deleted
    Then the subnet group no longer exists
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @delete_cache_subnet_group
  Scenario: a cache subnet group is deleted fails when the subnet group does not exist
    Given the subnet group does not exist
    When a cache subnet group is deleted
    Then the operation is rejected

  @guard @negative @delete_cache_subnet_group
  Scenario: a cache subnet group is deleted fails when the subnet group is not present
    Given the subnet group exists
    And the subnet group is not present
    When a cache subnet group is deleted
    Then the operation is rejected
