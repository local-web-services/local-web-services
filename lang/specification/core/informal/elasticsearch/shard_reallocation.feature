@elasticsearch @generated
Feature: Elasticsearch - Shards Are Reallocated Across Nodes In An Active Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @shard_reallocation @internal
  Scenario: shards are reallocated across nodes in an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is "ACTIVE"
    When shards are reallocated across nodes in an active domain
    Then the domain shard layout is updated without changing document counts
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @shard_reallocation @internal
  Scenario: shards are reallocated across nodes in an active domain fails when the domain does not exist
    Given the domain does not exist
    When shards are reallocated across nodes in an active domain
    Then the operation is rejected

  @standard @negative @shard_reallocation @internal
  Scenario: shards are reallocated across nodes in an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When shards are reallocated across nodes in an active domain
    Then the operation is rejected

  @standard @negative @shard_reallocation @internal
  Scenario: shards are reallocated across nodes in an active domain fails when the index does not exist
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not exist
    When shards are reallocated across nodes in an active domain
    Then the operation is rejected

  @standard @negative @shard_reallocation @internal
  Scenario: shards are reallocated across nodes in an active domain fails when the index is not "ACTIVE"
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is not "ACTIVE"
    When shards are reallocated across nodes in an active domain
    Then the operation is rejected
