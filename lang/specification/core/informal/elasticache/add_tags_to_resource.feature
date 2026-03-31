@elasticache @generated
Feature: Elasticache - Tags Are Added To An "Elasticache" "Resource"

  # Generated from FizzBee spec: elasticache.fizz
  # Safety invariants: MemcachedNotInReplicationGroup, SnapshotOnlyFromRedis, AvailableRGHasPrimary, TagsExistForResources, SnapshottingClusterHasSnapshot

  Background:
    Given the system is initialized

  @minimal @happy @add_tags_to_resource
  Scenario: tags are added to an "elasticache" "resource"
    Given the "elasticache" "resource" existed
    And the "elasticache" "resource" has tags
    When tags are added to an "elasticache" "resource"
    Then the "elasticache" "resource" remains tagged
    And memcached clusters are never associated with a "elasticache" "replication group"
    And all snapshots reference redis clusters only
    And every available replication group has a primary cluster assigned
    And every active cluster, replication group, and snapshot has tags
    And every snapshotting cluster has a corresponding in-progress snapshot

  @guard @negative @add_tags_to_resource
  Scenario: tags are added to an "elasticache" "resource" fails when the "elasticache" "resource" did not exist
    Given the "elasticache" "resource" did not exist
    When tags are added to an "elasticache" "resource"
    Then the operation is rejected

  @guard @negative @add_tags_to_resource
  Scenario: tags are added to an "elasticache" "resource" fails when the "elasticache" "resource" does not have tags
    Given the "elasticache" "resource" existed
    And the "elasticache" "resource" does not have tags
    When tags are added to an "elasticache" "resource"
    Then the operation is rejected
