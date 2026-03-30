@elasticache @generated
Feature: Elasticache - A Replication Group Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_replication_group
  Scenario: a replication group is deleted
    Given the replication group exists
    And the replication group is "AVAILABLE"
    When a replication group is deleted
    Then the replication group and its clusters are in "DELETING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @delete_replication_group
  Scenario: a replication group is deleted fails when the replication group does not exist
    Given the replication group does not exist
    When a replication group is deleted
    Then the operation is rejected

  @guard @negative @delete_replication_group @lifecycle
  Scenario: a replication group is deleted fails when the replication group is not "AVAILABLE"
    Given the replication group exists
    And the replication group is not "AVAILABLE"
    When a replication group is deleted
    Then the operation is rejected
