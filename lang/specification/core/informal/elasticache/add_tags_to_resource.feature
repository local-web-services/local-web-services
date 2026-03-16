@elasticache @generated
Feature: Elasticache - Tags Are Added To A Cache Resource

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @add_tags_to_resource
  Scenario: tags are added to a cache resource
    Given the resource exists
    And the resource has tags
    When tags are added to a cache resource
    Then the resource remains tagged
    And memcached clusters are never associated with a replication group
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @standard @negative @add_tags_to_resource
  Scenario: tags are added to a cache resource fails when the resource does not exist
    Given the resource does not exist
    When tags are added to a cache resource
    Then the operation is rejected

  @standard @negative @add_tags_to_resource
  Scenario: tags are added to a cache resource fails when the resource does not have tags
    Given the resource exists
    And the resource does not have tags
    When tags are added to a cache resource
    Then the operation is rejected
