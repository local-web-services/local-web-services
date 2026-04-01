@elasticache @generated
Feature: Elasticache - An "Elasticache" "Cluster" Is Created From An "Elasticache" "Snapshot"

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_cluster_from_snapshot
  Scenario: an "elasticache" "cluster" is created from an "elasticache" "snapshot"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "AVAILABLE"
    And the target "elasticache" "cluster" slot is available
    When an "elasticache" "cluster" is created from an "elasticache" "snapshot"
    Then the "elasticache" "cluster" will be in "RESTORING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @create_cache_cluster_from_snapshot
  Scenario: an "elasticache" "cluster" is created from an "elasticache" "snapshot" fails when the "elasticache" "snapshot" did not exist
    Given the "elasticache" "snapshot" did not exist
    When an "elasticache" "cluster" is created from an "elasticache" "snapshot"
    Then the operation is rejected

  @guard @negative @create_cache_cluster_from_snapshot @lifecycle
  Scenario: an "elasticache" "cluster" is created from an "elasticache" "snapshot" fails when the "elasticache" "snapshot" was not "AVAILABLE"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was not "AVAILABLE"
    When an "elasticache" "cluster" is created from an "elasticache" "snapshot"
    Then the operation is rejected

  @guard @negative @create_cache_cluster_from_snapshot
  Scenario: an "elasticache" "cluster" is created from an "elasticache" "snapshot" fails when the target "elasticache" "cluster" slot is not available
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "AVAILABLE"
    And the target "elasticache" "cluster" slot is not available
    When an "elasticache" "cluster" is created from an "elasticache" "snapshot"
    Then the operation is rejected
