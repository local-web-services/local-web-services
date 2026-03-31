@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_replication_group
  Scenario: a "elasticache" "replication group" is deleted
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    When a "elasticache" "replication group" is deleted
    Then the "elasticache" "replication group" and its clusters are in "DELETING" state
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @delete_replication_group
  Scenario: a "elasticache" "replication group" is deleted fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a "elasticache" "replication group" is deleted
    Then the operation is rejected

  @guard @negative @delete_replication_group @lifecycle
  Scenario: a "elasticache" "replication group" is deleted fails when the "elasticache" "replication group" was not "AVAILABLE"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "AVAILABLE"
    When a "elasticache" "replication group" is deleted
    Then the operation is rejected
