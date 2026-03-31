@elasticache @generated
Feature: Elasticache - An "Elasticache" "Cluster" Deletion Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cache_cluster_deletion @internal
  Scenario: an "elasticache" "cluster" deletion completes
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "DELETING"
    When an "elasticache" "cluster" deletion completes
    Then the "elasticache" "cluster" will be "DELETED" and its tags will be removed
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_cache_cluster_deletion @internal
  Scenario: an "elasticache" "cluster" deletion completes fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "cluster" deletion completes
    Then the operation is rejected

  @guard @negative @complete_cache_cluster_deletion @internal
  Scenario: an "elasticache" "cluster" deletion completes fails when the "elasticache" "cluster" was not "DELETING"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "DELETING"
    When an "elasticache" "cluster" deletion completes
    Then the operation is rejected
