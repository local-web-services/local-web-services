@elasticache @generated
Feature: Elasticache - An "Elasticache" "Snapshot" Finishes Creating

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "CREATING"
    And the "elasticache" "cluster" existed
    And the "elasticache" "snapshot" belongs to this "elasticache" "cluster"
    And the "elasticache" "cluster" was "SNAPSHOTTING"
    When an "elasticache" "snapshot" finishes creating
    Then the "elasticache" "snapshot" will be "AVAILABLE" and the "elasticache" "cluster" returns to "AVAILABLE" state
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

  @guard @negative @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating fails when the "elasticache" "snapshot" did not exist
    Given the "elasticache" "snapshot" did not exist
    When an "elasticache" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating fails when the "elasticache" "snapshot" was not "CREATING"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was not "CREATING"
    When an "elasticache" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "CREATING"
    And the "elasticache" "cluster" did not exist
    When an "elasticache" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating fails when the "elasticache" "snapshot" does not belong to this "elasticache" "cluster"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "CREATING"
    And the "elasticache" "cluster" existed
    And the "elasticache" "snapshot" does not belong to this "elasticache" "cluster"
    When an "elasticache" "snapshot" finishes creating
    Then the operation is rejected

  @guard @negative @complete_snapshot_creation @internal
  Scenario: an "elasticache" "snapshot" finishes creating fails when the "elasticache" "cluster" was not "SNAPSHOTTING"
    Given the "elasticache" "snapshot" existed
    And the "elasticache" "snapshot" was "CREATING"
    And the "elasticache" "cluster" existed
    And the "elasticache" "snapshot" belongs to this "elasticache" "cluster"
    And the "elasticache" "cluster" was not "SNAPSHOTTING"
    When an "elasticache" "snapshot" finishes creating
    Then the operation is rejected
