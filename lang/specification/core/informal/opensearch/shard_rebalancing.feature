@opensearch @generated
Feature: Opensearch - Shards Are Rebalanced Across Nodes In An Active Domain

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    When shards are rebalanced across nodes in an active domain
    Then the instance count is updated without data loss
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active domain fails when the domain does not exist
    Given the domain does not exist
    When shards are rebalanced across nodes in an active domain
    Then the operation is rejected

  @guard @negative @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When shards are rebalanced across nodes in an active domain
    Then the operation is rejected
