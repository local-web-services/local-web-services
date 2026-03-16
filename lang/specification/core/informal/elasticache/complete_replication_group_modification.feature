@elasticache @generated
Feature: Elasticache - A Replication Group Modification Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_modification @internal
  Scenario: a replication group modification completes
    Given the replication group exists
    And the replication group is "MODIFYING"
    When a replication group modification completes
    Then the replication group returns to "AVAILABLE" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_replication_group_modification @internal
  Scenario: a replication group modification completes fails when the replication group does not exist
    Given the replication group does not exist
    When a replication group modification completes
    Then the operation is rejected

  @standard @negative @complete_replication_group_modification @internal
  Scenario: a replication group modification completes fails when the replication group is not "MODIFYING"
    Given the replication group exists
    And the replication group is not "MODIFYING"
    When a replication group modification completes
    Then the operation is rejected
