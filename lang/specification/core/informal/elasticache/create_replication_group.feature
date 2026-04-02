@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_replication_group
  Scenario: a "elasticache" "replication group" is created
    Given the "elasticache" "replication group" did not already exist
    When a "elasticache" "replication group" is created
    Then the "elasticache" "replication group" will be in "CREATING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @create_replication_group
  Scenario: a "elasticache" "replication group" is created fails when the "elasticache" "replication group" already existed
    Given the "elasticache" "replication group" already existed
    When a "elasticache" "replication group" is created
    Then the operation is rejected
