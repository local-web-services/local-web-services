@elasticache @generated
Feature: Elasticache - A Replication Group Finishes Creating

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_creation @internal
  Scenario: a replication group finishes creating
    Given the replication group exists
    And the replication group is "CREATING"
    And a cluster slot is available for the primary
    When a replication group finishes creating
    Then the replication group and its primary cluster are "AVAILABLE"
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_replication_group_creation @internal
  Scenario: a replication group finishes creating fails when the replication group does not exist
    Given the replication group does not exist
    When a replication group finishes creating
    Then the operation is rejected

  @standard @negative @complete_replication_group_creation @internal
  Scenario: a replication group finishes creating fails when the replication group is not "CREATING"
    Given the replication group exists
    And the replication group is not "CREATING"
    When a replication group finishes creating
    Then the operation is rejected

  @standard @negative @complete_replication_group_creation @internal
  Scenario: a replication group finishes creating fails when no cluster slot is available for the primary
    Given the replication group exists
    And the replication group is "CREATING"
    And no cluster slot is available for the primary
    When a replication group finishes creating
    Then the operation is rejected
