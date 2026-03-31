@elasticache @generated
Feature: Elasticache - A Replica Creation In A "Elasticache" "Replication Group" Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_replica_creation @internal
  Scenario: a replica creation in a "elasticache" "replication group" completes
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "CREATING"
    And the "elasticache" "cluster" is part of a "elasticache" "replication group"
    When a replica creation in a "elasticache" "replication group" completes
    Then the replica "elasticache" "cluster" will be "AVAILABLE"
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a "elasticache" "replication group" completes fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When a replica creation in a "elasticache" "replication group" completes
    Then the operation is rejected

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a "elasticache" "replication group" completes fails when the "elasticache" "cluster" was not "CREATING"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "CREATING"
    When a replica creation in a "elasticache" "replication group" completes
    Then the operation is rejected

  @guard @negative @complete_replica_creation @internal
  Scenario: a replica creation in a "elasticache" "replication group" completes fails when the "elasticache" "cluster" is not part of a "elasticache" "replication group"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "CREATING"
    And the "elasticache" "cluster" is not part of a "elasticache" "replication group"
    When a replica creation in a "elasticache" "replication group" completes
    Then the operation is rejected
