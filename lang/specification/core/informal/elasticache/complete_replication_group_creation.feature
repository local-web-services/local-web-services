@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Finishes Creating

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_creation @internal
  Scenario: a "elasticache" "replication group" finishes creating
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "CREATING"
    And an "elasticache" "cluster" slot is available for the primary
    When a "elasticache" "replication group" finishes creating
    Then the "elasticache" "replication group" and its primary "elasticache" "cluster" are "AVAILABLE"
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_replication_group_creation @internal
  Scenario: a "elasticache" "replication group" finishes creating fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a "elasticache" "replication group" finishes creating
    Then the operation is rejected

  @guard @negative @complete_replication_group_creation @internal
  Scenario: a "elasticache" "replication group" finishes creating fails when the "elasticache" "replication group" was not "CREATING"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "CREATING"
    When a "elasticache" "replication group" finishes creating
    Then the operation is rejected

  @guard @negative @complete_replication_group_creation @internal
  Scenario: a "elasticache" "replication group" finishes creating fails when no "elasticache" "cluster" slot is available for the primary
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "CREATING"
    And no "elasticache" "cluster" slot is available for the primary
    When a "elasticache" "replication group" finishes creating
    Then the operation is rejected
