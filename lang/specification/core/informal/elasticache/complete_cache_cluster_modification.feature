@elasticache @generated
Feature: Elasticache - An "Elasticache" "Cluster" Modification Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cache_cluster_modification @internal
  Scenario: an "elasticache" "cluster" modification completes
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "MODIFYING"
    When an "elasticache" "cluster" modification completes
    Then the "elasticache" "cluster" returns to "AVAILABLE" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @complete_cache_cluster_modification @internal
  Scenario: an "elasticache" "cluster" modification completes fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "cluster" modification completes
    Then the operation is rejected

  @guard @negative @complete_cache_cluster_modification @internal
  Scenario: an "elasticache" "cluster" modification completes fails when the "elasticache" "cluster" was not "MODIFYING"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "MODIFYING"
    When an "elasticache" "cluster" modification completes
    Then the operation is rejected
