@elasticache @generated
Feature: Elasticache - An "Elasticache" "Cluster" Configuration Is Modified

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_cache_cluster
  Scenario: an "elasticache" "cluster" configuration is modified
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    When an "elasticache" "cluster" configuration is modified
    Then the "elasticache" "cluster" will be in "MODIFYING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @modify_cache_cluster
  Scenario: an "elasticache" "cluster" configuration is modified fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "cluster" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_cache_cluster @lifecycle
  Scenario: an "elasticache" "cluster" configuration is modified fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When an "elasticache" "cluster" configuration is modified
    Then the operation is rejected
