@elasticache @generated
Feature: Elasticache - A Standalone "Elasticache" "Cluster" Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_cache_cluster
  Scenario: a standalone "elasticache" "cluster" is deleted
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" is standalone (not part of a "elasticache" "replication group")
    When a standalone "elasticache" "cluster" is deleted
    Then the "elasticache" "cluster" will be in "DELETING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @delete_cache_cluster
  Scenario: a standalone "elasticache" "cluster" is deleted fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When a standalone "elasticache" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_cache_cluster @lifecycle
  Scenario: a standalone "elasticache" "cluster" is deleted fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When a standalone "elasticache" "cluster" is deleted
    Then the operation is rejected

  @guard @negative @delete_cache_cluster
  Scenario: a standalone "elasticache" "cluster" is deleted fails when the "elasticache" "cluster" is part of a "elasticache" "replication group"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" is part of a "elasticache" "replication group"
    When a standalone "elasticache" "cluster" is deleted
    Then the operation is rejected
