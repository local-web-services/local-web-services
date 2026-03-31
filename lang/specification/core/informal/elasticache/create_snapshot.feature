@elasticache @generated
Feature: Elasticache - An "Elasticache" "Snapshot" Is Created From An Available Redis "Elasticache" "Cluster"

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" uses the redis engine
    And the "elasticache" "snapshot" slot is available
    When an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Then the "elasticache" "snapshot" will be in "CREATING" state and the "elasticache" "cluster" will be "SNAPSHOTTING"
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @create_snapshot
  Scenario: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Then the operation is rejected

  @guard @negative @create_snapshot @lifecycle
  Scenario: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Then the operation is rejected

  @guard @negative @create_snapshot
  Scenario: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" fails when the "elasticache" "cluster" does not use the redis engine
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" does not use the redis engine
    When an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Then the operation is rejected

  @guard @negative @create_snapshot
  Scenario: an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster" fails when the "elasticache" "snapshot" slot is not available
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And the "elasticache" "cluster" uses the redis engine
    And the "elasticache" "snapshot" slot is not available
    When an "elasticache" "snapshot" is created from an available redis "elasticache" "cluster"
    Then the operation is rejected
