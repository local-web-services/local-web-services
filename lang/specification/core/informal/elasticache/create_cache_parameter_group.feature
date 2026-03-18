@elasticache @generated
Feature: Elasticache - A Cache Parameter Group Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_parameter_group
  Scenario: a cache parameter group is created
    Given the parameter group does not already exist
    When a cache parameter group is created
    Then the parameter group exists
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @create_cache_parameter_group
  Scenario: a cache parameter group is created fails when the parameter group already exists
    Given the parameter group already exists
    When a cache parameter group is created
    Then the operation is rejected
