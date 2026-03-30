@elasticache @generated
Feature: Elasticache - An Automatic Failover Promotes A New Primary In A Replication Group

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is enabled
    And a replica cluster exists
    And the cluster is part of this replication group
    And the cluster is "AVAILABLE"
    And the cluster is not already the primary
    When an automatic failover promotes a new primary in a replication group
    Then the replication group has a new primary cluster
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when the replication group does not exist
    Given the replication group does not exist
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when the replication group is not "AVAILABLE"
    Given the replication group exists
    And the replication group is not "AVAILABLE"
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when automatic failover is not enabled
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is not enabled
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when no replica cluster exists
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is enabled
    And no replica cluster exists
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when the cluster is not part of this replication group
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is enabled
    And a replica cluster exists
    And the cluster is not part of this replication group
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when the cluster is not "AVAILABLE"
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is enabled
    And a replica cluster exists
    And the cluster is part of this replication group
    And the cluster is not "AVAILABLE"
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected

  @guard @negative @failover_replication_group @internal
  Scenario: an automatic failover promotes a new primary in a replication group fails when the cluster is already the primary
    Given the replication group exists
    And the replication group is "AVAILABLE"
    And automatic failover is enabled
    And a replica cluster exists
    And the cluster is part of this replication group
    And the cluster is "AVAILABLE"
    And the cluster is already the primary
    When an automatic failover promotes a new primary in a replication group
    Then the operation is rejected
