@elasticache @generated
Feature: Elasticache - A Standalone Cache Cluster Is Deleted

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @delete_cache_cluster
  Scenario: a standalone cache cluster is deleted
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the cluster is standalone (not part of a replication group)
    When a standalone cache cluster is deleted
    Then the cluster is in "DELETING" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @delete_cache_cluster
  Scenario: a standalone cache cluster is deleted fails when the cluster does not exist
    Given the cluster does not exist
    When a standalone cache cluster is deleted
    Then the operation is rejected

  @standard @negative @delete_cache_cluster @lifecycle @internal
  Scenario: a standalone cache cluster is deleted fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a standalone cache cluster is deleted
    Then the operation is rejected

  @standard @negative @delete_cache_cluster
  Scenario: a standalone cache cluster is deleted fails when the cluster is part of a replication group
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the cluster is part of a replication group
    When a standalone cache cluster is deleted
    Then the operation is rejected
