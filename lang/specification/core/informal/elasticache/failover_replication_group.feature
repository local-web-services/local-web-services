@elasticache @generated
Feature: Elasticache - An Automatic Failover Promotes A New Primary In A "Elasticache" "Replication Group"

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was "ENABLED"
    And a replica "elasticache" "cluster" existed
    And the "elasticache" "cluster" is part of this replication group
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" was not already the primary
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the "elasticache" "replication group" has a new primary "elasticache" "cluster"
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when the "elasticache" "replication group" did not exist
    Given the "elasticache" "replication group" did not exist
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when the "elasticache" "replication group" was not "AVAILABLE"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was not "AVAILABLE"
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when automatic failover was not "ENABLED"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was not "ENABLED"
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when no replica "elasticache" "cluster" existed
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was "ENABLED"
    And no replica "elasticache" "cluster" existed
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when the "elasticache" "cluster" is not part of this replication group
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was "ENABLED"
    And a replica "elasticache" "cluster" existed
    And the "elasticache" "cluster" is not part of this replication group
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was "ENABLED"
    And a replica "elasticache" "cluster" existed
    And the "elasticache" "cluster" is part of this replication group
    And the "elasticache" "cluster" was not "AVAILABLE"
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a "elasticache" "replication group" fails when the "elasticache" "cluster" was already the primary
    Given the "elasticache" "replication group" existed
    And the "elasticache" "replication group" was "AVAILABLE"
    And automatic failover was "ENABLED"
    And a replica "elasticache" "cluster" existed
    And the "elasticache" "cluster" is part of this replication group
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" was already the primary
    When an automatic failover promotes a new primary in a "elasticache" "replication group"
    Then the operation is rejected
