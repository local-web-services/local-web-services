@elasticache @generated
Feature: Elasticache - An "Elasticache" "Snapshot" Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_deletion @internal
  Scenario: an "elasticache" "snapshot" deletion completes
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "DELETING"
    When an "elasticache" "snapshot" deletion completes
    Then the "elasticache" "snapshot" will be "DELETED" and its tags will be removed
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: an "elasticache" "snapshot" deletion completes fails when the "elasticache" "snapshot" did not exist
    Given the "elasticache" "snapshot" did not exist
    When an "elasticache" "snapshot" deletion completes
    Then the operation is rejected

  @guard @negative @complete_snapshot_deletion @internal
  Scenario: an "elasticache" "snapshot" deletion completes fails when the "elasticache" "snapshot" was not "DELETING"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was not "DELETING"
    When an "elasticache" "snapshot" deletion completes
    Then the operation is rejected
