@elasticache @generated
Feature: Elasticache - A Replica Is Added To A Replication Group

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @add_replica_to_cache_cluster
  Scenario: a replica is added to a replication group
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And a cluster slot is available
    When a replica is added to a replication group
    Then a new cluster is in "CREATING" state and associated with the replication group
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @add_replica_to_cache_cluster
  Scenario: a replica is added to a replication group fails when the replication group does not exist
    Given the replication group does not exist
    When a replica is added to a replication group
    Then the operation is rejected

  @standard @negative @add_replica_to_cache_cluster @lifecycle @internal
  Scenario: a replica is added to a replication group fails when the replication group is not "AVAILABLE"
    Given the replication group exists
    And the replication group is not "AVAILABLE"
    When a replica is added to a replication group
    Then the operation is rejected

  @standard @negative @add_replica_to_cache_cluster
  Scenario: a replica is added to a replication group fails when no cluster slot is available
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And no cluster slot is available
    When a replica is added to a replication group
    Then the operation is rejected
