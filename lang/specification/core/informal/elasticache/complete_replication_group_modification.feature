@elasticache @generated
Feature: Elasticache - A "Elasticache" "Replication Group" Modification Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replication_group_modification @internal
  Scenario: a "elasticache" "replication group" modification completes
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "MODIFYING"
    When a "elasticache" "replication group" modification completes
    Then the "elasticache" "replication group" returns to "AVAILABLE" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @complete_replication_group_modification @internal
  Scenario: a "elasticache" "replication group" modification completes fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When a "elasticache" "replication group" modification completes
    Then the operation is rejected

  @guard @negative @complete_replication_group_modification @internal
  Scenario: a "elasticache" "replication group" modification completes fails when the "elasticache" "replication group" was not "MODIFYING"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "MODIFYING"
    When a "elasticache" "replication group" modification completes
    Then the operation is rejected
