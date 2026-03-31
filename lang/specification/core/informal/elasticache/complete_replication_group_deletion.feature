@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_deletion @internal
  Scenario: a "elasticache" "replication group" deletion completes
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "DELETING"
    When a "elasticache" "replication group" deletion completes
    Then the "elasticache" "replication group" will be "DELETED" and its tags will be removed
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_replication_group_deletion @internal
  Scenario: a "elasticache" "replication group" deletion completes fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a "elasticache" "replication group" deletion completes
    Then the operation is rejected

  @guard @negative @complete_replication_group_deletion @internal
  Scenario: a "elasticache" "replication group" deletion completes fails when the "elasticache" "replication group" was not "DELETING"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "DELETING"
    When a "elasticache" "replication group" deletion completes
    Then the operation is rejected
