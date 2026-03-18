@elasticache @generated
Feature: Elasticache - A Replication Group Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_deletion @internal
  Scenario: a replication group deletion completes
    Given the replication group exists
    And the replication group is "DELETING"
    When a replication group deletion completes
    Then the replication group is "DELETED" and its tags are removed
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_replication_group_deletion @internal
  Scenario: a replication group deletion completes fails when the replication group does not exist
    Given the replication group does not exist
    When a replication group deletion completes
    Then the operation is rejected

  @standard @negative @complete_replication_group_deletion @internal
  Scenario: a replication group deletion completes fails when the replication group is not "DELETING"
    Given the replication group exists
    And the replication group is not "DELETING"
    When a replication group deletion completes
    Then the operation is rejected
