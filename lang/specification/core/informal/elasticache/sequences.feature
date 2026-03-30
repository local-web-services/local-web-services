@elasticache @generated
Feature: Elasticache - Action Sequences

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @sequence
  Scenario: a redis cache cluster is created then a memcached cache cluster is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a standalone cache cluster finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster configuration is modified
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster modification completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a standalone cache cluster is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group configuration is modified
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group modification completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then an automatic failover promotes a new primary in a replication group
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replica is added to a replication group
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replica creation in a replication group completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a snapshot is created from an available redis cache cluster
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster is created from a snapshot
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache parameter group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache parameter group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache subnet group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache subnet group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then tags are added to a cache resource
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then tags are removed from a cache resource
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a redis cache cluster is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a standalone cache cluster finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster configuration is modified
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster modification completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a standalone cache cluster is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group configuration is modified
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group modification completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then an automatic failover promotes a new primary in a replication group
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replica is added to a replication group
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replica creation in a replication group completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a snapshot is created from an available redis cache cluster
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster is created from a snapshot
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache parameter group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache parameter group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache subnet group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache subnet group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then tags are added to a cache resource
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then tags are removed from a cache resource
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a redis cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a memcached cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replica is added to a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache parameter group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache parameter group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache subnet group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache subnet group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then tags are added to a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then tags are removed from a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster modification has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a redis cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a memcached cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replica is added to a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache parameter group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache parameter group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache subnet group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache subnet group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then tags are added to a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then tags are removed from a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a redis cache cluster is created
    Given rgid not in rg_status
    Given a replication group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a memcached cache cluster is created
    Given rgid not in rg_status
    Given a replication group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a standalone cache cluster finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster configuration is modified
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster modification completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a standalone cache cluster is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group configuration is modified
    Given rgid not in rg_status
    Given a replication group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group modification completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then an automatic failover promotes a new primary in a replication group
    Given rgid not in rg_status
    Given a replication group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replica is added to a replication group
    Given rgid not in rg_status
    Given a replication group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replica creation in a replication group completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a snapshot is created from an available redis cache cluster
    Given rgid not in rg_status
    Given a replication group has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster is created from a snapshot
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster restore from snapshot completes
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache parameter group is created
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache parameter group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache subnet group is created
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache subnet group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then tags are added to a cache resource
    Given rgid not in rg_status
    Given a replication group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then tags are removed from a cache resource
    Given rgid not in rg_status
    Given a replication group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group has finished creating
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group modification completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group modification completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group configuration has been modified
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group modification has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group modification has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group modification has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group modification has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group modification has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group modification has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group modification completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group modification completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group deletion has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a redis cache cluster is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a memcached cache cluster is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster configuration is modified
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster modification completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group configuration is modified
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group modification completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replica is added to a replication group
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replica creation in a replication group completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache parameter group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache parameter group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache subnet group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache subnet group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then tags are added to a cache resource
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then tags are removed from a cache resource
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a redis cache cluster is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster modification completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group configuration is modified
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group modification completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache parameter group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache subnet group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then tags are added to a cache resource
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replica has been added to a replication group
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster modification completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group modification completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache parameter group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache subnet group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a redis cache cluster is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a memcached cache cluster is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster modification completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group configuration is modified
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group modification completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replica is added to a replication group
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache parameter group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache parameter group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache subnet group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache subnet group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then tags are added to a cache resource
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then tags are removed from a cache resource
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group modification completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a redis cache cluster is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a memcached cache cluster is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a standalone cache cluster finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster configuration is modified
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster modification completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a standalone cache cluster is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group configuration is modified
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group modification completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then an automatic failover promotes a new primary in a replication group
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replica is added to a replication group
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replica creation in a replication group completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a snapshot is created from an available redis cache cluster
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster is created from a snapshot
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster restore from snapshot completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache parameter group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache subnet group is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache subnet group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then tags are added to a cache resource
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then tags are removed from a cache resource
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a redis cache cluster is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a memcached cache cluster is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a standalone cache cluster finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster configuration is modified
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster modification completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a standalone cache cluster is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group configuration is modified
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group modification completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then an automatic failover promotes a new primary in a replication group
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replica is added to a replication group
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replica creation in a replication group completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a snapshot is created from an available redis cache cluster
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster is created from a snapshot
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster restore from snapshot completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache parameter group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache subnet group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache subnet group is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then tags are added to a cache resource
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then tags are removed from a cache resource
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a redis cache cluster is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a memcached cache cluster is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a standalone cache cluster finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster configuration is modified
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster modification completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a standalone cache cluster is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group configuration is modified
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group modification completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then an automatic failover promotes a new primary in a replication group
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replica is added to a replication group
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replica creation in a replication group completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a snapshot is created from an available redis cache cluster
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster is created from a snapshot
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster restore from snapshot completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache parameter group is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache parameter group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache subnet group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then tags are added to a cache resource
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then tags are removed from a cache resource
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a redis cache cluster is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a memcached cache cluster is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a standalone cache cluster finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster configuration is modified
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster modification completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a standalone cache cluster is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group configuration is modified
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group modification completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then an automatic failover promotes a new primary in a replication group
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replica is added to a replication group
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replica creation in a replication group completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a snapshot is created from an available redis cache cluster
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster is created from a snapshot
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster restore from snapshot completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache parameter group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache parameter group is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache subnet group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then tags are added to a cache resource
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then tags are removed from a cache resource
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a redis cache cluster is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a memcached cache cluster is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a standalone cache cluster finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster configuration is modified
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster modification completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a standalone cache cluster is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group configuration is modified
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group modification completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then an automatic failover promotes a new primary in a replication group
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replica is added to a replication group
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replica creation in a replication group completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a snapshot is created from an available redis cache cluster
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster is created from a snapshot
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster restore from snapshot completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache parameter group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache parameter group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache subnet group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache subnet group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then tags are removed from a cache resource
    Given cid in tag_exists
    Given tags have been added to a cache resource
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a redis cache cluster is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a memcached cache cluster is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a standalone cache cluster finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster configuration is modified
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster modification completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a standalone cache cluster is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group configuration is modified
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group modification completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then an automatic failover promotes a new primary in a replication group
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replica is added to a replication group
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replica creation in a replication group completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a snapshot is created from an available redis cache cluster
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster is created from a snapshot
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster restore from snapshot completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache parameter group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache parameter group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache subnet group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache subnet group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then tags are added to a cache resource
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a memcached cache cluster is created then a standalone cache cluster finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a memcached cache cluster has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a standalone cache cluster finishes creating then a cache cluster configuration is modified
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a standalone cache cluster has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster configuration is modified then a cache cluster modification completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache cluster configuration has been modified
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster modification completes then a standalone cache cluster is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache cluster modification has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a standalone cache cluster is deleted then a cache cluster deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a standalone cache cluster has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster deletion completes then a replication group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache cluster deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group is created then a replication group finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group finishes creating then a replication group configuration is modified
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group configuration is modified then a replication group modification completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group configuration has been modified
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group modification completes then a replication group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group modification has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group is deleted then a replication group deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replication group deletion completes then an automatic failover promotes a new primary in a replication group
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replication group deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then an automatic failover promotes a new primary in a replication group then a replica is added to a replication group
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given an automatic failover has promoted a new primary in a replication group
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replica is added to a replication group then a replica creation in a replication group completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replica has been added to a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a replica creation in a replication group completes then a snapshot is created from an available redis cache cluster
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a replica creation in a replication group has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a snapshot is created from an available redis cache cluster then a cache snapshot finishes creating
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot finishes creating then a cache snapshot is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache snapshot has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot is deleted then a cache snapshot deletion completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache snapshot has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache snapshot deletion completes then a cache cluster is created from a snapshot
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache snapshot deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster is created from a snapshot then a cache cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache cluster has been created from a snapshot
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache cluster restore from snapshot completes then a cache parameter group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache parameter group is created then a cache parameter group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache parameter group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache parameter group is deleted then a cache subnet group is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache parameter group has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache subnet group is created then a cache subnet group is deleted
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache subnet group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then a cache subnet group is deleted then tags are added to a cache resource
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given a cache subnet group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then tags are added to a cache resource then tags are removed from a cache resource
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given tags have been added to a cache resource
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a redis cache cluster is created then tags are removed from a cache resource then a memcached cache cluster is created
    Given cid not in cluster_status
    Given a redis cache cluster has been created
    Given tags have been removed from a cache resource
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a redis cache cluster is created then a cache cluster configuration is modified
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a redis cache cluster has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a standalone cache cluster finishes creating then a cache cluster modification completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a standalone cache cluster has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster configuration is modified then a standalone cache cluster is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache cluster configuration has been modified
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster modification completes then a cache cluster deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache cluster modification has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a standalone cache cluster is deleted then a replication group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a standalone cache cluster has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster deletion completes then a replication group finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache cluster deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group is created then a replication group configuration is modified
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group finishes creating then a replication group modification completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group configuration is modified then a replication group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group configuration has been modified
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group modification completes then a replication group deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group modification has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group is deleted then an automatic failover promotes a new primary in a replication group
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replication group deletion completes then a replica is added to a replication group
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replication group deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then an automatic failover promotes a new primary in a replication group then a replica creation in a replication group completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given an automatic failover has promoted a new primary in a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replica is added to a replication group then a snapshot is created from an available redis cache cluster
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replica has been added to a replication group
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a replica creation in a replication group completes then a cache snapshot finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a replica creation in a replication group has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a snapshot is created from an available redis cache cluster then a cache snapshot is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot finishes creating then a cache snapshot deletion completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache snapshot has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot is deleted then a cache cluster is created from a snapshot
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache snapshot has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache snapshot deletion completes then a cache cluster restore from snapshot completes
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache snapshot deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster is created from a snapshot then a cache parameter group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache cluster has been created from a snapshot
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache cluster restore from snapshot completes then a cache parameter group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache parameter group is created then a cache subnet group is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache parameter group has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache parameter group is deleted then a cache subnet group is deleted
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache parameter group has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache subnet group is created then tags are added to a cache resource
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache subnet group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then a cache subnet group is deleted then tags are removed from a cache resource
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given a cache subnet group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then tags are added to a cache resource then a redis cache cluster is created
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given tags have been added to a cache resource
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a memcached cache cluster is created then tags are removed from a cache resource then a standalone cache cluster finishes creating
    Given cid not in cluster_status
    Given a memcached cache cluster has been created
    Given tags have been removed from a cache resource
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a redis cache cluster is created then a cache cluster modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a redis cache cluster has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a memcached cache cluster is created then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a memcached cache cluster has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster configuration is modified then a cache cluster deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache cluster configuration has been modified
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster modification completes then a replication group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache cluster modification has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a standalone cache cluster is deleted then a replication group finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a standalone cache cluster has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster deletion completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache cluster deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group is created then a replication group modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group finishes creating then a replication group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group configuration is modified then a replication group deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group configuration has been modified
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group modification completes then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group modification has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group is deleted then a replica is added to a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replication group deletion completes then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replication group deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then an automatic failover promotes a new primary in a replication group then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given an automatic failover has promoted a new primary in a replication group
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replica is added to a replication group then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replica has been added to a replication group
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a replica creation in a replication group completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a replica creation in a replication group has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a snapshot is created from an available redis cache cluster then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot finishes creating then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache snapshot has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot is deleted then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache snapshot has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache snapshot deletion completes then a cache parameter group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache snapshot deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster is created from a snapshot then a cache parameter group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache cluster has been created from a snapshot
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache cluster restore from snapshot completes then a cache subnet group is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache cluster restore from snapshot has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache parameter group is created then a cache subnet group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache parameter group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache parameter group is deleted then tags are added to a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache parameter group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache subnet group is created then tags are removed from a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache subnet group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then a cache subnet group is deleted then a redis cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given a cache subnet group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then tags are added to a cache resource then a memcached cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given tags have been added to a cache resource
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster finishes creating then tags are removed from a cache resource then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has finished creating
    Given tags have been removed from a cache resource
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a redis cache cluster is created then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a redis cache cluster has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a memcached cache cluster is created then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a memcached cache cluster has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a standalone cache cluster finishes creating then a replication group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a standalone cache cluster has finished creating
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster modification completes then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache cluster modification has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a standalone cache cluster is deleted then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a standalone cache cluster has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster deletion completes then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache cluster deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group is created then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group finishes creating then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group configuration is modified then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group configuration has been modified
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group modification completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group modification has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group is deleted then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replication group deletion completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replication group deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then an automatic failover promotes a new primary in a replication group then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replica is added to a replication group then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replica has been added to a replication group
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a replica creation in a replication group completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a replica creation in a replication group has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a snapshot is created from an available redis cache cluster then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot finishes creating then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache snapshot has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot is deleted then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache snapshot has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache snapshot deletion completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache snapshot deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster is created from a snapshot then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache cluster has been created from a snapshot
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache cluster restore from snapshot completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache cluster restore from snapshot has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache parameter group is created then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache parameter group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache parameter group is deleted then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache parameter group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache subnet group is created then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache subnet group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then a cache subnet group is deleted then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given a cache subnet group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then tags are added to a cache resource then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given tags have been added to a cache resource
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster configuration is modified then tags are removed from a cache resource then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster configuration has been modified
    Given tags have been removed from a cache resource
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a redis cache cluster is created then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a redis cache cluster has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a memcached cache cluster is created then a replication group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a memcached cache cluster has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a standalone cache cluster finishes creating then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a standalone cache cluster has finished creating
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster configuration is modified then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache cluster configuration has been modified
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a standalone cache cluster is deleted then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a standalone cache cluster has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster deletion completes then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache cluster deletion has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group is created then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group finishes creating then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group configuration is modified then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group configuration has been modified
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group modification completes then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group modification has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group is deleted then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replication group deletion completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replication group deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then an automatic failover promotes a new primary in a replication group then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replica is added to a replication group then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replica has been added to a replication group
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a replica creation in a replication group completes then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a replica creation in a replication group has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a snapshot is created from an available redis cache cluster then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot finishes creating then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache snapshot has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot is deleted then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache snapshot has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache snapshot deletion completes then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache snapshot deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster is created from a snapshot then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache cluster has been created from a snapshot
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache cluster restore from snapshot completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache cluster restore from snapshot has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache parameter group is created then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache parameter group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache parameter group is deleted then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache parameter group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache subnet group is created then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache subnet group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then a cache subnet group is deleted then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given a cache subnet group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then tags are added to a cache resource then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given tags have been added to a cache resource
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster modification completes then tags are removed from a cache resource then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster modification has completed
    Given tags have been removed from a cache resource
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a redis cache cluster is created then a replication group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a redis cache cluster has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a memcached cache cluster is created then a replication group finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a memcached cache cluster has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a standalone cache cluster finishes creating then a replication group configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a standalone cache cluster has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster configuration is modified then a replication group modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache cluster configuration has been modified
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster modification completes then a replication group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache cluster modification has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster deletion completes then a replication group deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache cluster deletion has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group is created then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group finishes creating then a replica is added to a replication group
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group configuration is modified then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group configuration has been modified
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group modification completes then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group modification has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group is deleted then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replication group deletion completes then a cache snapshot is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replication group deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then an automatic failover promotes a new primary in a replication group then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given an automatic failover has promoted a new primary in a replication group
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replica is added to a replication group then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replica has been added to a replication group
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a replica creation in a replication group completes then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a replica creation in a replication group has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a snapshot is created from an available redis cache cluster then a cache parameter group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a snapshot has been created from an available redis cache cluster
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot finishes creating then a cache parameter group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache snapshot has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot is deleted then a cache subnet group is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache snapshot has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache snapshot deletion completes then a cache subnet group is deleted
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache snapshot deletion has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster is created from a snapshot then tags are added to a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache cluster has been created from a snapshot
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache cluster restore from snapshot completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache cluster restore from snapshot has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache parameter group is created then a redis cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache parameter group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache parameter group is deleted then a memcached cache cluster is created
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache parameter group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache subnet group is created then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache subnet group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then a cache subnet group is deleted then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given a cache subnet group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then tags are added to a cache resource then a cache cluster modification completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given tags have been added to a cache resource
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a standalone cache cluster is deleted then tags are removed from a cache resource then a cache cluster deletion completes
    Given cid in cluster_status
    Given a standalone cache cluster has been deleted
    Given tags have been removed from a cache resource
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a redis cache cluster is created then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a redis cache cluster has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a memcached cache cluster is created then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a memcached cache cluster has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a standalone cache cluster finishes creating then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a standalone cache cluster has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster configuration is modified then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache cluster configuration has been modified
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster modification completes then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache cluster modification has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a standalone cache cluster is deleted then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a standalone cache cluster has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group is created then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group finishes creating then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group configuration is modified then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group configuration has been modified
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group modification completes then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group modification has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group is deleted then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replication group deletion completes then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replication group deletion has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then an automatic failover promotes a new primary in a replication group then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replica is added to a replication group then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replica has been added to a replication group
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a replica creation in a replication group completes then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a replica creation in a replication group has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a snapshot is created from an available redis cache cluster then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a snapshot has been created from an available redis cache cluster
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot finishes creating then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache snapshot has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot is deleted then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache snapshot has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache snapshot deletion completes then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache snapshot deletion has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster is created from a snapshot then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache cluster has been created from a snapshot
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache cluster restore from snapshot completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache cluster restore from snapshot has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache parameter group is created then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache parameter group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache parameter group is deleted then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache parameter group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache subnet group is created then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache subnet group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then a cache subnet group is deleted then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given a cache subnet group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then tags are added to a cache resource then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given tags have been added to a cache resource
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster deletion completes then tags are removed from a cache resource then a replication group is created
    Given cid in cluster_status
    Given a cache cluster deletion has completed
    Given tags have been removed from a cache resource
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a redis cache cluster is created then a replication group configuration is modified
    Given rgid not in rg_status
    Given a replication group has been created
    Given a redis cache cluster has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a memcached cache cluster is created then a replication group modification completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given a memcached cache cluster has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a standalone cache cluster finishes creating then a replication group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    Given a standalone cache cluster has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster configuration is modified then a replication group deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache cluster configuration has been modified
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster modification completes then an automatic failover promotes a new primary in a replication group
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache cluster modification has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a standalone cache cluster is deleted then a replica is added to a replication group
    Given rgid not in rg_status
    Given a replication group has been created
    Given a standalone cache cluster has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster deletion completes then a replica creation in a replication group completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache cluster deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group finishes creating then a snapshot is created from an available redis cache cluster
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replication group has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group configuration is modified then a cache snapshot finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replication group configuration has been modified
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group modification completes then a cache snapshot is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replication group modification has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group is deleted then a cache snapshot deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replication group has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replication group deletion completes then a cache cluster is created from a snapshot
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replication group deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then an automatic failover promotes a new primary in a replication group then a cache cluster restore from snapshot completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replica is added to a replication group then a cache parameter group is created
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replica has been added to a replication group
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a replica creation in a replication group completes then a cache parameter group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    Given a replica creation in a replication group has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a snapshot is created from an available redis cache cluster then a cache subnet group is created
    Given rgid not in rg_status
    Given a replication group has been created
    Given a snapshot has been created from an available redis cache cluster
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot finishes creating then a cache subnet group is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache snapshot has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot is deleted then tags are added to a cache resource
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache snapshot has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache snapshot deletion completes then tags are removed from a cache resource
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache snapshot deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster is created from a snapshot then a redis cache cluster is created
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache cluster has been created from a snapshot
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache cluster restore from snapshot completes then a memcached cache cluster is created
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache cluster restore from snapshot has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache parameter group is created then a standalone cache cluster finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache parameter group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache parameter group is deleted then a cache cluster configuration is modified
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache parameter group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache subnet group is created then a cache cluster modification completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache subnet group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then a cache subnet group is deleted then a standalone cache cluster is deleted
    Given rgid not in rg_status
    Given a replication group has been created
    Given a cache subnet group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then tags are added to a cache resource then a cache cluster deletion completes
    Given rgid not in rg_status
    Given a replication group has been created
    Given tags have been added to a cache resource
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is created then tags are removed from a cache resource then a replication group finishes creating
    Given rgid not in rg_status
    Given a replication group has been created
    Given tags have been removed from a cache resource
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a redis cache cluster is created then a replication group modification completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a redis cache cluster has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a memcached cache cluster is created then a replication group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a memcached cache cluster has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a standalone cache cluster finishes creating then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a standalone cache cluster has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster configuration is modified then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache cluster configuration has been modified
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster modification completes then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache cluster modification has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a standalone cache cluster is deleted then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a standalone cache cluster has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster deletion completes then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache cluster deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group is created then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replication group has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group configuration is modified then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replication group configuration has been modified
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group modification completes then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replication group modification has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group is deleted then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replication group has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replication group deletion completes then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replication group deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then an automatic failover promotes a new primary in a replication group then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    Given an automatic failover has promoted a new primary in a replication group
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replica is added to a replication group then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replica has been added to a replication group
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a replica creation in a replication group completes then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a replica creation in a replication group has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a snapshot is created from an available redis cache cluster then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a snapshot has been created from an available redis cache cluster
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot finishes creating then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache snapshot has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot is deleted then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache snapshot has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache snapshot deletion completes then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache snapshot deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster is created from a snapshot then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache cluster has been created from a snapshot
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache cluster restore from snapshot completes then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache cluster restore from snapshot has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache parameter group is created then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache parameter group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache parameter group is deleted then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache parameter group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache subnet group is created then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache subnet group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then a cache subnet group is deleted then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group has finished creating
    Given a cache subnet group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then tags are added to a cache resource then a replication group is created
    Given rgid in rg_status
    Given a replication group has finished creating
    Given tags have been added to a cache resource
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group finishes creating then tags are removed from a cache resource then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group has finished creating
    Given tags have been removed from a cache resource
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a redis cache cluster is created then a replication group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a redis cache cluster has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a memcached cache cluster is created then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a memcached cache cluster has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a standalone cache cluster finishes creating then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a standalone cache cluster has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster configuration is modified then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache cluster configuration has been modified
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster modification completes then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache cluster modification has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a standalone cache cluster is deleted then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a standalone cache cluster has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster deletion completes then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache cluster deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group is created then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replication group has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group finishes creating then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replication group has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group modification completes then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replication group modification has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group is deleted then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replication group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replication group deletion completes then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replication group deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then an automatic failover promotes a new primary in a replication group then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given an automatic failover has promoted a new primary in a replication group
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replica is added to a replication group then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replica has been added to a replication group
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a replica creation in a replication group completes then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a replica creation in a replication group has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a snapshot is created from an available redis cache cluster then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a snapshot has been created from an available redis cache cluster
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot finishes creating then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache snapshot has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot is deleted then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache snapshot has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache snapshot deletion completes then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache snapshot deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster is created from a snapshot then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache cluster has been created from a snapshot
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache cluster restore from snapshot completes then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache cluster restore from snapshot has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache parameter group is created then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache parameter group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache parameter group is deleted then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache parameter group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache subnet group is created then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache subnet group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then a cache subnet group is deleted then a replication group is created
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given a cache subnet group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then tags are added to a cache resource then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given tags have been added to a cache resource
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group configuration is modified then tags are removed from a cache resource then a replication group modification completes
    Given rgid in rg_status
    Given a replication group configuration has been modified
    Given tags have been removed from a cache resource
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a redis cache cluster is created then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a redis cache cluster has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a memcached cache cluster is created then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a memcached cache cluster has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a standalone cache cluster finishes creating then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a standalone cache cluster has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster configuration is modified then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache cluster configuration has been modified
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster modification completes then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache cluster modification has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a standalone cache cluster is deleted then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a standalone cache cluster has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster deletion completes then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache cluster deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group is created then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replication group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group finishes creating then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replication group has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group configuration is modified then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replication group configuration has been modified
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group is deleted then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replication group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replication group deletion completes then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replication group deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then an automatic failover promotes a new primary in a replication group then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replica is added to a replication group then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replica has been added to a replication group
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a replica creation in a replication group completes then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a replica creation in a replication group has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a snapshot is created from an available redis cache cluster then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a snapshot has been created from an available redis cache cluster
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot finishes creating then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache snapshot has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot is deleted then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache snapshot has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache snapshot deletion completes then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache snapshot deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster is created from a snapshot then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache cluster has been created from a snapshot
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache cluster restore from snapshot completes then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache cluster restore from snapshot has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache parameter group is created then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache parameter group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache parameter group is deleted then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache parameter group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache subnet group is created then a replication group is created
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache subnet group has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then a cache subnet group is deleted then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group modification has completed
    Given a cache subnet group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then tags are added to a cache resource then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group modification has completed
    Given tags have been added to a cache resource
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group modification completes then tags are removed from a cache resource then a replication group is deleted
    Given rgid in rg_status
    Given a replication group modification has completed
    Given tags have been removed from a cache resource
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a redis cache cluster is created then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a redis cache cluster has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a memcached cache cluster is created then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a memcached cache cluster has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a standalone cache cluster finishes creating then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a standalone cache cluster has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster configuration is modified then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache cluster configuration has been modified
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster modification completes then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache cluster modification has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a standalone cache cluster is deleted then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a standalone cache cluster has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster deletion completes then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache cluster deletion has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group is created then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replication group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group finishes creating then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replication group has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group configuration is modified then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replication group configuration has been modified
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group modification completes then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replication group modification has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replication group deletion completes then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replication group deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then an automatic failover promotes a new primary in a replication group then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    Given an automatic failover has promoted a new primary in a replication group
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replica is added to a replication group then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replica has been added to a replication group
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a replica creation in a replication group completes then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a replica creation in a replication group has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a snapshot is created from an available redis cache cluster then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a snapshot has been created from an available redis cache cluster
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot finishes creating then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache snapshot has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot is deleted then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache snapshot has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache snapshot deletion completes then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache snapshot deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster is created from a snapshot then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache cluster has been created from a snapshot
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache cluster restore from snapshot completes then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache cluster restore from snapshot has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache parameter group is created then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache parameter group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache parameter group is deleted then a replication group is created
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache parameter group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache subnet group is created then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache subnet group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then a cache subnet group is deleted then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group has been deleted
    Given a cache subnet group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then tags are added to a cache resource then a replication group modification completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given tags have been added to a cache resource
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group is deleted then tags are removed from a cache resource then a replication group deletion completes
    Given rgid in rg_status
    Given a replication group has been deleted
    Given tags have been removed from a cache resource
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a redis cache cluster is created then a replica is added to a replication group
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a redis cache cluster has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a memcached cache cluster is created then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a memcached cache cluster has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a standalone cache cluster finishes creating then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a standalone cache cluster has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster configuration is modified then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache cluster configuration has been modified
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster modification completes then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache cluster modification has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a standalone cache cluster is deleted then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a standalone cache cluster has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster deletion completes then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache cluster deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group is created then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replication group has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group finishes creating then a cache parameter group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replication group has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group configuration is modified then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replication group configuration has been modified
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group modification completes then a cache subnet group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replication group modification has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replication group is deleted then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replication group has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then an automatic failover promotes a new primary in a replication group then tags are added to a cache resource
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given an automatic failover has promoted a new primary in a replication group
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replica is added to a replication group then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replica has been added to a replication group
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a replica creation in a replication group completes then a redis cache cluster is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a replica creation in a replication group has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a snapshot is created from an available redis cache cluster then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a snapshot has been created from an available redis cache cluster
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot finishes creating then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache snapshot has finished creating
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot is deleted then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache snapshot has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache snapshot deletion completes then a cache cluster modification completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache snapshot deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster is created from a snapshot then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache cluster has been created from a snapshot
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache cluster restore from snapshot completes then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache cluster restore from snapshot has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache parameter group is created then a replication group is created
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache parameter group has been created
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache parameter group is deleted then a replication group finishes creating
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache parameter group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache subnet group is created then a replication group configuration is modified
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache subnet group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then a cache subnet group is deleted then a replication group modification completes
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given a cache subnet group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then tags are added to a cache resource then a replication group is deleted
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given tags have been added to a cache resource
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replication group deletion completes then tags are removed from a cache resource then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replication group deletion has completed
    Given tags have been removed from a cache resource
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a redis cache cluster is created then a replica creation in a replication group completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a redis cache cluster has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a memcached cache cluster is created then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a memcached cache cluster has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a standalone cache cluster finishes creating then a cache snapshot finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a standalone cache cluster has finished creating
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster configuration is modified then a cache snapshot is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache cluster configuration has been modified
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster modification completes then a cache snapshot deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache cluster modification has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a standalone cache cluster is deleted then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a standalone cache cluster has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster deletion completes then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache cluster deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group is created then a cache parameter group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group finishes creating then a cache parameter group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group configuration is modified then a cache subnet group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group configuration has been modified
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group modification completes then a cache subnet group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group modification has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group is deleted then tags are added to a cache resource
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replication group deletion completes then tags are removed from a cache resource
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replication group deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replica is added to a replication group then a redis cache cluster is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replica has been added to a replication group
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a replica creation in a replication group completes then a memcached cache cluster is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a replica creation in a replication group has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a snapshot is created from an available redis cache cluster then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a snapshot has been created from an available redis cache cluster
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot finishes creating then a cache cluster configuration is modified
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache snapshot has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot is deleted then a cache cluster modification completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache snapshot has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache snapshot deletion completes then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache snapshot deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster is created from a snapshot then a cache cluster deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache cluster has been created from a snapshot
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache cluster restore from snapshot completes then a replication group is created
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache cluster restore from snapshot has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache parameter group is created then a replication group finishes creating
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache parameter group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache parameter group is deleted then a replication group configuration is modified
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache parameter group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache subnet group is created then a replication group modification completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache subnet group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then a cache subnet group is deleted then a replication group is deleted
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given a cache subnet group has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then tags are added to a cache resource then a replication group deletion completes
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given tags have been added to a cache resource
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: an automatic failover promotes a new primary in a replication group then tags are removed from a cache resource then a replica is added to a replication group
    Given rgid in rg_status
    Given an automatic failover has promoted a new primary in a replication group
    Given tags have been removed from a cache resource
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a redis cache cluster is created then a snapshot is created from an available redis cache cluster
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a redis cache cluster has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a memcached cache cluster is created then a cache snapshot finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a memcached cache cluster has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a standalone cache cluster finishes creating then a cache snapshot is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a standalone cache cluster has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster configuration is modified then a cache snapshot deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache cluster configuration has been modified
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster modification completes then a cache cluster is created from a snapshot
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache cluster modification has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a standalone cache cluster is deleted then a cache cluster restore from snapshot completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a standalone cache cluster has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster deletion completes then a cache parameter group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache cluster deletion has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group is created then a cache parameter group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group finishes creating then a cache subnet group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group configuration is modified then a cache subnet group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group configuration has been modified
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group modification completes then tags are added to a cache resource
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group modification has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group is deleted then tags are removed from a cache resource
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replication group deletion completes then a redis cache cluster is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replication group deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then an automatic failover promotes a new primary in a replication group then a memcached cache cluster is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given an automatic failover has promoted a new primary in a replication group
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a replica creation in a replication group completes then a standalone cache cluster finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a replica creation in a replication group has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a snapshot is created from an available redis cache cluster then a cache cluster configuration is modified
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot finishes creating then a cache cluster modification completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache snapshot has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot is deleted then a standalone cache cluster is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache snapshot has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache snapshot deletion completes then a cache cluster deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache snapshot deletion has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster is created from a snapshot then a replication group is created
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache cluster has been created from a snapshot
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache cluster restore from snapshot completes then a replication group finishes creating
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache cluster restore from snapshot has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache parameter group is created then a replication group configuration is modified
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache parameter group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache parameter group is deleted then a replication group modification completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache parameter group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache subnet group is created then a replication group is deleted
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache subnet group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then a cache subnet group is deleted then a replication group deletion completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given a cache subnet group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then tags are added to a cache resource then an automatic failover promotes a new primary in a replication group
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given tags have been added to a cache resource
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica is added to a replication group then tags are removed from a cache resource then a replica creation in a replication group completes
    Given rgid in rg_status
    Given a replica has been added to a replication group
    Given tags have been removed from a cache resource
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a redis cache cluster is created then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a redis cache cluster has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a memcached cache cluster is created then a cache snapshot is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a memcached cache cluster has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a standalone cache cluster finishes creating then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a standalone cache cluster has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster configuration is modified then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache cluster configuration has been modified
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster modification completes then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache cluster modification has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a standalone cache cluster is deleted then a cache parameter group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a standalone cache cluster has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster deletion completes then a cache parameter group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache cluster deletion has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group is created then a cache subnet group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group finishes creating then a cache subnet group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group configuration is modified then tags are added to a cache resource
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group configuration has been modified
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group modification completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group modification has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group is deleted then a redis cache cluster is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replication group deletion completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replication group deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then an automatic failover promotes a new primary in a replication group then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a replica is added to a replication group then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a replica has been added to a replication group
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a snapshot is created from an available redis cache cluster then a cache cluster modification completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a snapshot has been created from an available redis cache cluster
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot finishes creating then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache snapshot has finished creating
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot is deleted then a cache cluster deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache snapshot has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache snapshot deletion completes then a replication group is created
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache snapshot deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster is created from a snapshot then a replication group finishes creating
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache cluster has been created from a snapshot
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache cluster restore from snapshot completes then a replication group configuration is modified
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache cluster restore from snapshot has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache parameter group is created then a replication group modification completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache parameter group has been created
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache parameter group is deleted then a replication group is deleted
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache parameter group has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache subnet group is created then a replication group deletion completes
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache subnet group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then a cache subnet group is deleted then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given a cache subnet group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then tags are added to a cache resource then a replica is added to a replication group
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given tags have been added to a cache resource
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a replica creation in a replication group completes then tags are removed from a cache resource then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a replica creation in a replication group has completed
    Given tags have been removed from a cache resource
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a redis cache cluster is created then a cache snapshot is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a redis cache cluster has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a memcached cache cluster is created then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a memcached cache cluster has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a standalone cache cluster finishes creating then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a standalone cache cluster has finished creating
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster configuration is modified then a cache cluster restore from snapshot completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache cluster configuration has been modified
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster modification completes then a cache parameter group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache cluster modification has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a standalone cache cluster is deleted then a cache parameter group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a standalone cache cluster has been deleted
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster deletion completes then a cache subnet group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache cluster deletion has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group is created then a cache subnet group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group finishes creating then tags are added to a cache resource
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group configuration is modified then tags are removed from a cache resource
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group configuration has been modified
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group modification completes then a redis cache cluster is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group modification has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group is deleted then a memcached cache cluster is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replication group deletion completes then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replication group deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then an automatic failover promotes a new primary in a replication group then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replica is added to a replication group then a cache cluster modification completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replica has been added to a replication group
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a replica creation in a replication group completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a replica creation in a replication group has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot finishes creating then a cache cluster deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache snapshot has finished creating
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot is deleted then a replication group is created
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache snapshot has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache snapshot deletion completes then a replication group finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache snapshot deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster is created from a snapshot then a replication group configuration is modified
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache cluster has been created from a snapshot
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache cluster restore from snapshot completes then a replication group modification completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache cluster restore from snapshot has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache parameter group is created then a replication group is deleted
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache parameter group has been created
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache parameter group is deleted then a replication group deletion completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache parameter group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache subnet group is created then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache subnet group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then a cache subnet group is deleted then a replica is added to a replication group
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given a cache subnet group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then tags are added to a cache resource then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given tags have been added to a cache resource
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a snapshot is created from an available redis cache cluster then tags are removed from a cache resource then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a snapshot has been created from an available redis cache cluster
    Given tags have been removed from a cache resource
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a redis cache cluster is created then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a redis cache cluster has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a memcached cache cluster is created then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a memcached cache cluster has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a standalone cache cluster finishes creating then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a standalone cache cluster has finished creating
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster configuration is modified then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache cluster configuration has been modified
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster modification completes then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache cluster modification has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a standalone cache cluster is deleted then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a standalone cache cluster has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster deletion completes then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache cluster deletion has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group is created then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group finishes creating then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group configuration is modified then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group configuration has been modified
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group modification completes then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group modification has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group is deleted then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replication group deletion completes then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replication group deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then an automatic failover promotes a new primary in a replication group then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replica is added to a replication group then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replica has been added to a replication group
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a replica creation in a replication group completes then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a replica creation in a replication group has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a snapshot is created from an available redis cache cluster then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a snapshot has been created from an available redis cache cluster
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache snapshot is deleted then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache snapshot has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache snapshot deletion completes then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache snapshot deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster is created from a snapshot then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache cluster has been created from a snapshot
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache cluster restore from snapshot completes then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache cluster restore from snapshot has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache parameter group is created then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache parameter group has been created
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache parameter group is deleted then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache parameter group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache subnet group is created then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache subnet group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then a cache subnet group is deleted then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given a cache subnet group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then tags are added to a cache resource then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given tags have been added to a cache resource
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot finishes creating then tags are removed from a cache resource then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache snapshot has finished creating
    Given tags have been removed from a cache resource
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a redis cache cluster is created then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a redis cache cluster has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a memcached cache cluster is created then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a memcached cache cluster has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a standalone cache cluster finishes creating then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a standalone cache cluster has finished creating
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster configuration is modified then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache cluster configuration has been modified
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster modification completes then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache cluster modification has completed
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a standalone cache cluster is deleted then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a standalone cache cluster has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster deletion completes then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache cluster deletion has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group is created then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group finishes creating then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group configuration is modified then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group configuration has been modified
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group modification completes then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group modification has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group is deleted then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replication group deletion completes then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replication group deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then an automatic failover promotes a new primary in a replication group then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given an automatic failover has promoted a new primary in a replication group
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replica is added to a replication group then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replica has been added to a replication group
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a replica creation in a replication group completes then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a replica creation in a replication group has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a snapshot is created from an available redis cache cluster then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a snapshot has been created from an available redis cache cluster
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache snapshot finishes creating then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache snapshot has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache snapshot deletion completes then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache snapshot deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster is created from a snapshot then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache cluster has been created from a snapshot
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache cluster restore from snapshot completes then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache cluster restore from snapshot has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache parameter group is created then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache parameter group has been created
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache parameter group is deleted then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache parameter group has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache subnet group is created then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache subnet group has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then a cache subnet group is deleted then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given a cache subnet group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then tags are added to a cache resource then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given tags have been added to a cache resource
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot is deleted then tags are removed from a cache resource then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache snapshot has been deleted
    Given tags have been removed from a cache resource
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a redis cache cluster is created then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a redis cache cluster has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a memcached cache cluster is created then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a memcached cache cluster has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a standalone cache cluster finishes creating then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a standalone cache cluster has finished creating
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster configuration is modified then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache cluster configuration has been modified
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster modification completes then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache cluster modification has completed
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a standalone cache cluster is deleted then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a standalone cache cluster has been deleted
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster deletion completes then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache cluster deletion has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group is created then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group finishes creating then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group configuration is modified then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group configuration has been modified
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group modification completes then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group modification has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group is deleted then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replication group deletion completes then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replication group deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then an automatic failover promotes a new primary in a replication group then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replica is added to a replication group then a replication group is created
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replica has been added to a replication group
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a replica creation in a replication group completes then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a replica creation in a replication group has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a snapshot is created from an available redis cache cluster then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a snapshot has been created from an available redis cache cluster
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache snapshot finishes creating then a replication group modification completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache snapshot has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache snapshot is deleted then a replication group is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache snapshot has been deleted
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster is created from a snapshot then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache cluster has been created from a snapshot
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache cluster restore from snapshot completes then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache cluster restore from snapshot has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache parameter group is created then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache parameter group has been created
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache parameter group is deleted then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache parameter group has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache subnet group is created then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache subnet group has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then a cache subnet group is deleted then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given a cache subnet group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then tags are added to a cache resource then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given tags have been added to a cache resource
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache snapshot deletion completes then tags are removed from a cache resource then a cache cluster is created from a snapshot
    Given sid in snapshot_status
    Given a cache snapshot deletion has completed
    Given tags have been removed from a cache resource
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a redis cache cluster is created then a cache parameter group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a redis cache cluster has been created
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a memcached cache cluster is created then a cache parameter group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a memcached cache cluster has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a standalone cache cluster finishes creating then a cache subnet group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a standalone cache cluster has finished creating
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster configuration is modified then a cache subnet group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache cluster configuration has been modified
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster modification completes then tags are added to a cache resource
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache cluster modification has completed
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a standalone cache cluster is deleted then tags are removed from a cache resource
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a standalone cache cluster has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster deletion completes then a redis cache cluster is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache cluster deletion has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group is created then a memcached cache cluster is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group finishes creating then a standalone cache cluster finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group has finished creating
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group configuration is modified then a cache cluster configuration is modified
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group configuration has been modified
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group modification completes then a cache cluster modification completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group modification has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group is deleted then a standalone cache cluster is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group has been deleted
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replication group deletion completes then a cache cluster deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replication group deletion has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then an automatic failover promotes a new primary in a replication group then a replication group is created
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replica is added to a replication group then a replication group finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replica has been added to a replication group
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a replica creation in a replication group completes then a replication group configuration is modified
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a replica creation in a replication group has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a snapshot is created from an available redis cache cluster then a replication group modification completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a snapshot has been created from an available redis cache cluster
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot finishes creating then a replication group is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache snapshot has finished creating
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot is deleted then a replication group deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache snapshot has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache snapshot deletion completes then an automatic failover promotes a new primary in a replication group
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache snapshot deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache cluster restore from snapshot completes then a replica is added to a replication group
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache cluster restore from snapshot has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache parameter group is created then a replica creation in a replication group completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache parameter group has been created
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache parameter group is deleted then a snapshot is created from an available redis cache cluster
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache parameter group has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache subnet group is created then a cache snapshot finishes creating
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache subnet group has been created
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then a cache subnet group is deleted then a cache snapshot is deleted
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given a cache subnet group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then tags are added to a cache resource then a cache snapshot deletion completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given tags have been added to a cache resource
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster is created from a snapshot then tags are removed from a cache resource then a cache cluster restore from snapshot completes
    Given sid in snapshot_status
    Given a cache cluster has been created from a snapshot
    Given tags have been removed from a cache resource
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a redis cache cluster is created then a cache parameter group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a redis cache cluster has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a memcached cache cluster is created then a cache subnet group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a memcached cache cluster has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a standalone cache cluster finishes creating then a cache subnet group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a standalone cache cluster has finished creating
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster configuration is modified then tags are added to a cache resource
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache cluster configuration has been modified
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster modification completes then tags are removed from a cache resource
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache cluster modification has completed
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a standalone cache cluster is deleted then a redis cache cluster is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a standalone cache cluster has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster deletion completes then a memcached cache cluster is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache cluster deletion has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group is created then a standalone cache cluster finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group finishes creating then a cache cluster configuration is modified
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group configuration is modified then a cache cluster modification completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group configuration has been modified
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group modification completes then a standalone cache cluster is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group modification has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group is deleted then a cache cluster deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replication group deletion completes then a replication group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replication group deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then an automatic failover promotes a new primary in a replication group then a replication group finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replica is added to a replication group then a replication group configuration is modified
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replica has been added to a replication group
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a replica creation in a replication group completes then a replication group modification completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a replica creation in a replication group has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a snapshot is created from an available redis cache cluster then a replication group is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a snapshot has been created from an available redis cache cluster
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot finishes creating then a replication group deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache snapshot has finished creating
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot is deleted then an automatic failover promotes a new primary in a replication group
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache snapshot has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache snapshot deletion completes then a replica is added to a replication group
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache snapshot deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache cluster is created from a snapshot then a replica creation in a replication group completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache cluster has been created from a snapshot
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache parameter group is created then a snapshot is created from an available redis cache cluster
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache parameter group has been created
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache parameter group is deleted then a cache snapshot finishes creating
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache parameter group has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache subnet group is created then a cache snapshot is deleted
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache subnet group has been created
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then a cache subnet group is deleted then a cache snapshot deletion completes
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given a cache subnet group has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then tags are added to a cache resource then a cache cluster is created from a snapshot
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given tags have been added to a cache resource
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache cluster restore from snapshot completes then tags are removed from a cache resource then a cache parameter group is created
    Given cid in cluster_status
    Given a cache cluster restore from snapshot has completed
    Given tags have been removed from a cache resource
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a redis cache cluster is created then a cache subnet group is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a redis cache cluster has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a memcached cache cluster is created then a cache subnet group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a memcached cache cluster has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a standalone cache cluster finishes creating then tags are added to a cache resource
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a standalone cache cluster has finished creating
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster configuration is modified then tags are removed from a cache resource
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache cluster configuration has been modified
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster modification completes then a redis cache cluster is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache cluster modification has completed
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a standalone cache cluster is deleted then a memcached cache cluster is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a standalone cache cluster has been deleted
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster deletion completes then a standalone cache cluster finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache cluster deletion has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group is created then a cache cluster configuration is modified
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group finishes creating then a cache cluster modification completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group configuration is modified then a standalone cache cluster is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group configuration has been modified
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group modification completes then a cache cluster deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group modification has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group is deleted then a replication group is created
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replication group deletion completes then a replication group finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replication group deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then an automatic failover promotes a new primary in a replication group then a replication group configuration is modified
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replica is added to a replication group then a replication group modification completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replica has been added to a replication group
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a replica creation in a replication group completes then a replication group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a replica creation in a replication group has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a snapshot is created from an available redis cache cluster then a replication group deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a snapshot has been created from an available redis cache cluster
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot finishes creating then an automatic failover promotes a new primary in a replication group
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache snapshot has finished creating
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot is deleted then a replica is added to a replication group
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache snapshot has been deleted
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache snapshot deletion completes then a replica creation in a replication group completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache snapshot deletion has completed
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster is created from a snapshot then a snapshot is created from an available redis cache cluster
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache cluster has been created from a snapshot
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache cluster restore from snapshot completes then a cache snapshot finishes creating
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache parameter group is deleted then a cache snapshot is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache parameter group has been deleted
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache subnet group is created then a cache snapshot deletion completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache subnet group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then a cache subnet group is deleted then a cache cluster is created from a snapshot
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given a cache subnet group has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then tags are added to a cache resource then a cache cluster restore from snapshot completes
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given tags have been added to a cache resource
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is created then tags are removed from a cache resource then a cache parameter group is deleted
    Given pgid not in pg_exists
    Given a cache parameter group has been created
    Given tags have been removed from a cache resource
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a redis cache cluster is created then a cache subnet group is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a redis cache cluster has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a memcached cache cluster is created then tags are added to a cache resource
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a memcached cache cluster has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a standalone cache cluster finishes creating then tags are removed from a cache resource
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a standalone cache cluster has finished creating
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster configuration is modified then a redis cache cluster is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache cluster configuration has been modified
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster modification completes then a memcached cache cluster is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache cluster modification has completed
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a standalone cache cluster is deleted then a standalone cache cluster finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a standalone cache cluster has been deleted
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster deletion completes then a cache cluster configuration is modified
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache cluster deletion has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group is created then a cache cluster modification completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group has been created
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group finishes creating then a standalone cache cluster is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group has finished creating
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group configuration is modified then a cache cluster deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group configuration has been modified
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group modification completes then a replication group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group modification has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group is deleted then a replication group finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group has been deleted
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replication group deletion completes then a replication group configuration is modified
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replication group deletion has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then an automatic failover promotes a new primary in a replication group then a replication group modification completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replica is added to a replication group then a replication group is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replica has been added to a replication group
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a replica creation in a replication group completes then a replication group deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a replica creation in a replication group has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a snapshot is created from an available redis cache cluster then an automatic failover promotes a new primary in a replication group
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a snapshot has been created from an available redis cache cluster
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot finishes creating then a replica is added to a replication group
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache snapshot has finished creating
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot is deleted then a replica creation in a replication group completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache snapshot has been deleted
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache snapshot deletion completes then a snapshot is created from an available redis cache cluster
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache snapshot deletion has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster is created from a snapshot then a cache snapshot finishes creating
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache cluster has been created from a snapshot
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache cluster restore from snapshot completes then a cache snapshot is deleted
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache parameter group is created then a cache snapshot deletion completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache parameter group has been created
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache subnet group is created then a cache cluster is created from a snapshot
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache subnet group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then a cache subnet group is deleted then a cache cluster restore from snapshot completes
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given a cache subnet group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then tags are added to a cache resource then a cache parameter group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given tags have been added to a cache resource
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache parameter group is deleted then tags are removed from a cache resource then a cache subnet group is created
    Given pgid in pg_exists
    Given a cache parameter group has been deleted
    Given tags have been removed from a cache resource
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a redis cache cluster is created then tags are added to a cache resource
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a redis cache cluster has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a memcached cache cluster is created then tags are removed from a cache resource
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a memcached cache cluster has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a standalone cache cluster finishes creating then a redis cache cluster is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a standalone cache cluster has finished creating
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster configuration is modified then a memcached cache cluster is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache cluster configuration has been modified
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster modification completes then a standalone cache cluster finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache cluster modification has completed
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a standalone cache cluster is deleted then a cache cluster configuration is modified
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a standalone cache cluster has been deleted
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster deletion completes then a cache cluster modification completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache cluster deletion has completed
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group is created then a standalone cache cluster is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group has been created
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group finishes creating then a cache cluster deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group has finished creating
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group configuration is modified then a replication group is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group configuration has been modified
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group modification completes then a replication group finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group modification has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group is deleted then a replication group configuration is modified
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group has been deleted
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replication group deletion completes then a replication group modification completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replication group deletion has completed
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then an automatic failover promotes a new primary in a replication group then a replication group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replica is added to a replication group then a replication group deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replica has been added to a replication group
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a replica creation in a replication group completes then an automatic failover promotes a new primary in a replication group
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a replica creation in a replication group has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a snapshot is created from an available redis cache cluster then a replica is added to a replication group
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a snapshot has been created from an available redis cache cluster
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot finishes creating then a replica creation in a replication group completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache snapshot has finished creating
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot is deleted then a snapshot is created from an available redis cache cluster
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache snapshot has been deleted
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache snapshot deletion completes then a cache snapshot finishes creating
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache snapshot deletion has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster is created from a snapshot then a cache snapshot is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache cluster has been created from a snapshot
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache cluster restore from snapshot completes then a cache snapshot deletion completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache cluster restore from snapshot has completed
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache parameter group is created then a cache cluster is created from a snapshot
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache parameter group has been created
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache parameter group is deleted then a cache cluster restore from snapshot completes
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache parameter group has been deleted
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then a cache subnet group is deleted then a cache parameter group is created
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given a cache subnet group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then tags are added to a cache resource then a cache parameter group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given tags have been added to a cache resource
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is created then tags are removed from a cache resource then a cache subnet group is deleted
    Given sgid not in sg_exists
    Given a cache subnet group has been created
    Given tags have been removed from a cache resource
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a redis cache cluster is created then tags are removed from a cache resource
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a redis cache cluster has been created
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a memcached cache cluster is created then a redis cache cluster is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a memcached cache cluster has been created
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a standalone cache cluster finishes creating then a memcached cache cluster is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a standalone cache cluster has finished creating
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster configuration is modified then a standalone cache cluster finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache cluster configuration has been modified
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster modification completes then a cache cluster configuration is modified
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache cluster modification has completed
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a standalone cache cluster is deleted then a cache cluster modification completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a standalone cache cluster has been deleted
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster deletion completes then a standalone cache cluster is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache cluster deletion has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group is created then a cache cluster deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group has been created
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group finishes creating then a replication group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group has finished creating
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group configuration is modified then a replication group finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group configuration has been modified
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group modification completes then a replication group configuration is modified
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group modification has completed
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group is deleted then a replication group modification completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group has been deleted
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replication group deletion completes then a replication group is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replication group deletion has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then an automatic failover promotes a new primary in a replication group then a replication group deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given an automatic failover has promoted a new primary in a replication group
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replica is added to a replication group then an automatic failover promotes a new primary in a replication group
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replica has been added to a replication group
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a replica creation in a replication group completes then a replica is added to a replication group
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a replica creation in a replication group has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a snapshot is created from an available redis cache cluster then a replica creation in a replication group completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a snapshot has been created from an available redis cache cluster
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot finishes creating then a snapshot is created from an available redis cache cluster
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache snapshot has finished creating
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot is deleted then a cache snapshot finishes creating
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache snapshot has been deleted
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache snapshot deletion completes then a cache snapshot is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache snapshot deletion has completed
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster is created from a snapshot then a cache snapshot deletion completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache cluster has been created from a snapshot
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache cluster restore from snapshot completes then a cache cluster is created from a snapshot
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache cluster restore from snapshot has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache parameter group is created then a cache cluster restore from snapshot completes
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache parameter group has been created
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache parameter group is deleted then a cache parameter group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache parameter group has been deleted
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then a cache subnet group is created then a cache parameter group is deleted
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given a cache subnet group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then tags are added to a cache resource then a cache subnet group is created
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given tags have been added to a cache resource
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: a cache subnet group is deleted then tags are removed from a cache resource then tags are added to a cache resource
    Given sgid in sg_exists
    Given a cache subnet group has been deleted
    Given tags have been removed from a cache resource
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a redis cache cluster is created then a memcached cache cluster is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a redis cache cluster has been created
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a memcached cache cluster is created then a standalone cache cluster finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a memcached cache cluster has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a standalone cache cluster finishes creating then a cache cluster configuration is modified
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a standalone cache cluster has finished creating
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster configuration is modified then a cache cluster modification completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache cluster configuration has been modified
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster modification completes then a standalone cache cluster is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache cluster modification has completed
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a standalone cache cluster is deleted then a cache cluster deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a standalone cache cluster has been deleted
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster deletion completes then a replication group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache cluster deletion has completed
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group is created then a replication group finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group has been created
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group finishes creating then a replication group configuration is modified
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group has finished creating
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group configuration is modified then a replication group modification completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group configuration has been modified
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group modification completes then a replication group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group modification has completed
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group is deleted then a replication group deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group has been deleted
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replication group deletion completes then an automatic failover promotes a new primary in a replication group
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replication group deletion has completed
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then an automatic failover promotes a new primary in a replication group then a replica is added to a replication group
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given an automatic failover has promoted a new primary in a replication group
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replica is added to a replication group then a replica creation in a replication group completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replica has been added to a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a replica creation in a replication group completes then a snapshot is created from an available redis cache cluster
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a replica creation in a replication group has completed
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a snapshot is created from an available redis cache cluster then a cache snapshot finishes creating
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot finishes creating then a cache snapshot is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache snapshot has finished creating
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot is deleted then a cache snapshot deletion completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache snapshot has been deleted
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache snapshot deletion completes then a cache cluster is created from a snapshot
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache snapshot deletion has completed
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster is created from a snapshot then a cache cluster restore from snapshot completes
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache cluster has been created from a snapshot
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache cluster restore from snapshot completes then a cache parameter group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache parameter group is created then a cache parameter group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache parameter group has been created
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache parameter group is deleted then a cache subnet group is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache parameter group has been deleted
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache subnet group is created then a cache subnet group is deleted
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache subnet group has been created
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then a cache subnet group is deleted then tags are removed from a cache resource
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given a cache subnet group has been deleted
    When tags are removed from a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are added to a cache resource then tags are removed from a cache resource then a redis cache cluster is created
    Given cid in tag_exists
    Given tags have been added to a cache resource
    Given tags have been removed from a cache resource
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a redis cache cluster is created then a standalone cache cluster finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a redis cache cluster has been created
    When a standalone cache cluster finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a memcached cache cluster is created then a cache cluster configuration is modified
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a memcached cache cluster has been created
    When a cache cluster configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a standalone cache cluster finishes creating then a cache cluster modification completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a standalone cache cluster has finished creating
    When a cache cluster modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster configuration is modified then a standalone cache cluster is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache cluster configuration has been modified
    When a standalone cache cluster is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster modification completes then a cache cluster deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache cluster modification has completed
    When a cache cluster deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a standalone cache cluster is deleted then a replication group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a standalone cache cluster has been deleted
    When a replication group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster deletion completes then a replication group finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache cluster deletion has completed
    When a replication group finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group is created then a replication group configuration is modified
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group has been created
    When a replication group configuration is modified
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group finishes creating then a replication group modification completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group has finished creating
    When a replication group modification completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group configuration is modified then a replication group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group configuration has been modified
    When a replication group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group modification completes then a replication group deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group modification has completed
    When a replication group deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group is deleted then an automatic failover promotes a new primary in a replication group
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group has been deleted
    When an automatic failover promotes a new primary in a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replication group deletion completes then a replica is added to a replication group
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replication group deletion has completed
    When a replica is added to a replication group
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then an automatic failover promotes a new primary in a replication group then a replica creation in a replication group completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given an automatic failover has promoted a new primary in a replication group
    When a replica creation in a replication group completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replica is added to a replication group then a snapshot is created from an available redis cache cluster
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replica has been added to a replication group
    When a snapshot is created from an available redis cache cluster
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a replica creation in a replication group completes then a cache snapshot finishes creating
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a replica creation in a replication group has completed
    When a cache snapshot finishes creating
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a snapshot is created from an available redis cache cluster then a cache snapshot is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a snapshot has been created from an available redis cache cluster
    When a cache snapshot is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot finishes creating then a cache snapshot deletion completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache snapshot has finished creating
    When a cache snapshot deletion completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot is deleted then a cache cluster is created from a snapshot
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache snapshot has been deleted
    When a cache cluster is created from a snapshot
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache snapshot deletion completes then a cache cluster restore from snapshot completes
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache snapshot deletion has completed
    When a cache cluster restore from snapshot completes
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster is created from a snapshot then a cache parameter group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache cluster has been created from a snapshot
    When a cache parameter group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache cluster restore from snapshot completes then a cache parameter group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache cluster restore from snapshot has completed
    When a cache parameter group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache parameter group is created then a cache subnet group is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache parameter group has been created
    When a cache subnet group is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache parameter group is deleted then a cache subnet group is deleted
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache parameter group has been deleted
    When a cache subnet group is deleted
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache subnet group is created then tags are added to a cache resource
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache subnet group has been created
    When tags are added to a cache resource
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then a cache subnet group is deleted then a redis cache cluster is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given a cache subnet group has been deleted
    When a redis cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @sequence
  Scenario: tags are removed from a cache resource then tags are added to a cache resource then a memcached cache cluster is created
    Given cid in tag_exists
    Given tags have been removed from a cache resource
    Given tags have been added to a cache resource
    When a memcached cache cluster is created
    Then memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot
