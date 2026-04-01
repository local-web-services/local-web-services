@elasticache @generated
Feature: Elasticache - An "Elasticache" "Cluster" Restore From "Elasticache" "Snapshot" Completes

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @complete_cluster_restore @internal
  Scenario: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "RESTORING"
    When an "elasticache" "cluster" restore from "elasticache" "snapshot" completes
    Then the "elasticache" "cluster" will be "AVAILABLE"
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @complete_cluster_restore @internal
  Scenario: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes fails when the "elasticache" "cluster" did not exist
    Given the "elasticache" "cluster" did not exist
    When an "elasticache" "cluster" restore from "elasticache" "snapshot" completes
    Then the operation is rejected

  @guard @negative @complete_cluster_restore @internal
  Scenario: an "elasticache" "cluster" restore from "elasticache" "snapshot" completes fails when the "elasticache" "cluster" was not "RESTORING"
    Given the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "RESTORING"
    When an "elasticache" "cluster" restore from "elasticache" "snapshot" completes
    Then the operation is rejected
