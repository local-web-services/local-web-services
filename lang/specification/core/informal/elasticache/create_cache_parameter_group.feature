@elasticache @generated
Feature: Elasticache - An "Elasticache" "Parameter Group" Is Created

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_cache_parameter_group
  Scenario: an "elasticache" "parameter group" is created
    Given the "elasticache" "parameter group" did not already exist
    When an "elasticache" "parameter group" is created
    Then the "elasticache" "parameter group" will exist
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @create_cache_parameter_group
  Scenario: an "elasticache" "parameter group" is created fails when the "elasticache" "parameter group" already existed
    Given the "elasticache" "parameter group" already existed
    When an "elasticache" "parameter group" is created
    Then the operation is rejected
