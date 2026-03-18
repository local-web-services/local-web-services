@elasticache @generated
Feature: Elasticache - A Cache Snapshot Finishes Creating

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot belongs to this cluster
    And the cluster is "SNAPSHOTTING"
    When a cache snapshot finishes creating
    Then the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating fails when the snapshot does not exist
    Given the snapshot does not exist
    When a cache snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating fails when the snapshot is not "CREATING"
    Given the snapshot exists
    And the snapshot is not "CREATING"
    When a cache snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating fails when the cluster does not exist
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster does not exist
    When a cache snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating fails when the snapshot does not belong to this cluster
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot does not belong to this cluster
    When a cache snapshot finishes creating
    Then the operation is rejected

  @standard @negative @complete_snapshot_creation @internal
  Scenario: a cache snapshot finishes creating fails when the cluster is not "SNAPSHOTTING"
    Given the snapshot exists
    And the snapshot is "CREATING"
    And the cluster exists
    And the snapshot belongs to this cluster
    And the cluster is not "SNAPSHOTTING"
    When a cache snapshot finishes creating
    Then the operation is rejected
