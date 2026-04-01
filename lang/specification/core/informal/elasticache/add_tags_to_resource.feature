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
    And "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"
    And all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only
    And every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned
    And every active "elasticache" "cluster", "replication group", and "snapshot" has tags
    And every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"

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
