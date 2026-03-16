@elasticache @generated
Feature: Elasticache - A Snapshot Is Created From An Available Redis Cache Cluster

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: a snapshot is created from an available redis cache cluster
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the cluster uses the redis engine
    And the snapshot slot is available
    When a snapshot is created from an available redis cache cluster
    Then the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @create_snapshot
  Scenario: a snapshot is created from an available redis cache cluster fails when the cluster does not exist
    Given the cluster does not exist
    When a snapshot is created from an available redis cache cluster
    Then the operation is rejected

  @standard @negative @create_snapshot @lifecycle
  Scenario: a snapshot is created from an available redis cache cluster fails when the cluster is not "AVAILABLE"
    Given the cluster exists
    And the cluster is not "AVAILABLE"
    When a snapshot is created from an available redis cache cluster
    Then the operation is rejected

  @standard @negative @create_snapshot
  Scenario: a snapshot is created from an available redis cache cluster fails when the cluster does not use the redis engine
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the cluster does not use the redis engine
    When a snapshot is created from an available redis cache cluster
    Then the operation is rejected

  @standard @negative @create_snapshot
  Scenario: a snapshot is created from an available redis cache cluster fails when the snapshot slot is not available
    Given the cluster exists
    And the cluster is "AVAILABLE"
    And the cluster uses the redis engine
    And the snapshot slot is not available
    When a snapshot is created from an available redis cache cluster
    Then the operation is rejected
