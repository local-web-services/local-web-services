@elasticache @generated
Feature: Elasticache - A Cache Snapshot Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_snapshot
  Scenario: a cache snapshot is deleted
    Given the snapshot exists
    And the snapshot is "AVAILABLE"
    When a cache snapshot is deleted
    Then the snapshot is in "DELETING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @delete_snapshot
  Scenario: a cache snapshot is deleted fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cache snapshot is deleted
    Then the operation is rejected

  @standard @negative @delete_snapshot @lifecycle @internal
  Scenario: a cache snapshot is deleted fails when the snapshot is not "AVAILABLE"
    Given the snapshot exists
    And the snapshot is not "AVAILABLE"
    When a cache snapshot is deleted
    Then the operation is rejected
