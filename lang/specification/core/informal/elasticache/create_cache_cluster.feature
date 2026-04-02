@elasticache @generated
Feature: Elasticache - A Redis "Elasticache" "Cluster" Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_cluster
  Scenario: a redis "elasticache" "cluster" is created
    Given the "elasticache" "cluster" did not already exist
    When a redis "elasticache" "cluster" is created
    Then the "elasticache" "cluster" will be in "CREATING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @create_cache_cluster
  Scenario: a redis "elasticache" "cluster" is created fails when the "elasticache" "cluster" already existed
    Given the "elasticache" "cluster" already existed
    When a redis "elasticache" "cluster" is created
    Then the operation is rejected
