@elasticache @generated
Feature: Elasticache - A Replication Group Configuration Is Modified

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_replication_group
  Scenario: a replication group configuration is modified
    Given the replication group exists
    And the replication group is "AVAILABLE"
    When a replication group configuration is modified
    Then the replication group is in "MODIFYING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @modify_replication_group
  Scenario: a replication group configuration is modified fails when the replication group does not exist
    Given the replication group does not exist
    When a replication group configuration is modified
    Then the operation is rejected

  @guard @negative @modify_replication_group @lifecycle
  Scenario: a replication group configuration is modified fails when the replication group is not "AVAILABLE"
    Given the replication group exists
    And the replication group is not "AVAILABLE"
    When a replication group configuration is modified
    Then the operation is rejected
