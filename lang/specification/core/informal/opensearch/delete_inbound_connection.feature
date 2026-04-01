@opensearch @generated
Feature: Opensearch - An Inbound Cross-Cluster Connection Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is not already "DELETING"
    And the "opensearch" "inbound connection" is not already "DELETED"
    When an inbound cross-cluster connection is deleted
    Then the "opensearch" "inbound connection" will be in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the "opensearch" "inbound connection" did not exist
    Given the "opensearch" "inbound connection" did not exist
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the "opensearch" "inbound connection" is already "DELETING"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is already "DELETING"
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the "opensearch" "inbound connection" is already "DELETED"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is not already "DELETING"
    And the "opensearch" "inbound connection" is already "DELETED"
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected
