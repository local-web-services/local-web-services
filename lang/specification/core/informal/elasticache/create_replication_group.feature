@elasticache @generated
Feature: Elasticache - A Replication Group Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_replication_group
  Scenario: a replication group is created
    Given the replication group does not already exist
    When a replication group is created
    Then the replication group is in "CREATING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @create_replication_group
  Scenario: a replication group is created fails when the replication group already exists
    Given the replication group already exists
    When a replication group is created
    Then the operation is rejected
