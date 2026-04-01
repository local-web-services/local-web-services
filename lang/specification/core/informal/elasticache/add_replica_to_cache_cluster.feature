@elasticache @generated
Feature: Elasticache - A Replica Is Added To A "Elasticache" "Replication Group"

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @add_replica_to_cache_cluster
  Scenario: a replica is added to a "elasticache" "replication group"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And an "elasticache" "cluster" slot is available
    When a replica is added to a "elasticache" "replication group"
    Then a new "elasticache" "cluster" will be in "CREATING" state and associated with the "elasticache" "replication group"
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @add_replica_to_cache_cluster
  Scenario: a replica is added to a "elasticache" "replication group" fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a replica is added to a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @add_replica_to_cache_cluster @lifecycle
  Scenario: a replica is added to a "elasticache" "replication group" fails when the "elasticache" "replication group" was not "AVAILABLE"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "AVAILABLE"
    When a replica is added to a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @add_replica_to_cache_cluster
  Scenario: a replica is added to a "elasticache" "replication group" fails when no "elasticache" "cluster" slot is available
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And no "elasticache" "cluster" slot is available
    When a replica is added to a "elasticache" "replication group"
    Then the operation is rejected
