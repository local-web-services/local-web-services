@elasticache @generated
Feature: Elasticache - A Cache Parameter Group Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_cache_parameter_group
  Scenario: a cache parameter group is deleted
    Given the parameter group exists
    And the parameter group is present
    When a cache parameter group is deleted
    Then the parameter group no longer exists
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @delete_cache_parameter_group
  Scenario: a cache parameter group is deleted fails when the parameter group does not exist
    Given the parameter group does not exist
    When a cache parameter group is deleted
    Then the operation is rejected

  @standard @negative @delete_cache_parameter_group
  Scenario: a cache parameter group is deleted fails when the parameter group is not present
    Given the parameter group exists
    And the parameter group is not present
    When a cache parameter group is deleted
    Then the operation is rejected
