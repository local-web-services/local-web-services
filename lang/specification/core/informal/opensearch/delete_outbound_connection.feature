@opensearch @generated
Feature: Opensearch - An Outbound Cross-Cluster Connection Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" is not already "DELETING"
    And the "opensearch" "outbound connection" is not already "DELETED"
    When an outbound cross-cluster connection is deleted
    Then the "opensearch" "outbound connection" will be in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the "opensearch" "outbound connection" did not exist
    Given the "opensearch" "outbound connection" did not exist
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the "opensearch" "outbound connection" is already "DELETING"
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" is already "DELETING"
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the "opensearch" "outbound connection" is already "DELETED"
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" is not already "DELETING"
    And the "opensearch" "outbound connection" is already "DELETED"
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected
