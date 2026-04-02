@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Configuration Is Modified

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @modify_replication_group
  Scenario: a "elasticache" "replication group" configuration is modified
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    When a "elasticache" "replication group" configuration is modified
    Then the "elasticache" "replication group" will be in "MODIFYING" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @modify_replication_group
  Scenario: a "elasticache" "replication group" configuration is modified fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a "elasticache" "replication group" configuration is modified
    Then the operation is rejected

  @guard @negative @modify_replication_group @lifecycle
  Scenario: a "elasticache" "replication group" configuration is modified fails when the "elasticache" "replication group" was not "AVAILABLE"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "AVAILABLE"
    When a "elasticache" "replication group" configuration is modified
    Then the operation is rejected
