@elasticache @generated
Feature: Elasticache - A Cache Snapshot Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: a cache snapshot deletion completes
    Given the snapshot exists
    And the snapshot is "DELETING"
    When a cache snapshot deletion completes
    Then the snapshot is "DELETED" and its tags are removed
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_snapshot_deletion @internal
  Scenario: a cache snapshot deletion completes fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cache snapshot deletion completes
    Then the operation is rejected

  @standard @negative @complete_snapshot_deletion @internal
  Scenario: a cache snapshot deletion completes fails when the snapshot is not "DELETING"
    Given the snapshot exists
    And the snapshot is not "DELETING"
    When a cache snapshot deletion completes
    Then the operation is rejected
