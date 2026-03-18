@elasticache @generated
Feature: Elasticache - A Standalone Cache Cluster Finishes Creating

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cache_cluster_creation @internal
  Scenario: a standalone cache cluster finishes creating
    Given the cluster exists
    And the cluster is "CREATING"
    And the cluster is standalone (not part of a replication group)
    When a standalone cache cluster finishes creating
    Then the cluster is "AVAILABLE"
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_cache_cluster_creation @internal
  Scenario: a standalone cache cluster finishes creating fails when the cluster does not exist
    Given the cluster does not exist
    When a standalone cache cluster finishes creating
    Then the operation is rejected

  @standard @negative @complete_cache_cluster_creation @internal
  Scenario: a standalone cache cluster finishes creating fails when the cluster is not "CREATING"
    Given the cluster exists
    And the cluster is not "CREATING"
    When a standalone cache cluster finishes creating
    Then the operation is rejected

  @standard @negative @complete_cache_cluster_creation @internal
  Scenario: a standalone cache cluster finishes creating fails when the cluster is part of a replication group
    Given the cluster exists
    And the cluster is "CREATING"
    And the cluster is part of a replication group
    When a standalone cache cluster finishes creating
    Then the operation is rejected
