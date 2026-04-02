@opensearch @generated
Feature: Opensearch - Shards Are Rebalanced Across Nodes In An Active "Opensearch" "Domain"

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    Then the "opensearch" "domain" instance count will be updated without data loss
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @shard_rebalancing @internal
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" fails when the "opensearch" "domain" was not "ACTIVE"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "ACTIVE"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    Then the operation is rejected
