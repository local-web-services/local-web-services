@elasticache @generated
Feature: Elasticache - An "Elasticache" "Snapshot" Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_snapshot
  Scenario: an "elasticache" "snapshot" is deleted
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "AVAILABLE"
    When an "elasticache" "snapshot" is deleted
    Then the "elasticache" "snapshot" will be in "DELETING" state
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @delete_snapshot
  Scenario: an "elasticache" "snapshot" is deleted fails when the "elasticache" "snapshot" did not exist
    Given the "elasticache" "snapshot" did not exist
    When an "elasticache" "snapshot" is deleted
    Then the operation is rejected

  @guard @negative @delete_snapshot @lifecycle
  Scenario: an "elasticache" "snapshot" is deleted fails when the "elasticache" "snapshot" was not "AVAILABLE"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was not "AVAILABLE"
    When an "elasticache" "snapshot" is deleted
    Then the operation is rejected
