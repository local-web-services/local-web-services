@opensearch @generated
Feature: Opensearch - An Inbound Cross-Cluster Connection Is Accepted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE"
    And the "opensearch" "outbound connection" existed
    When an inbound cross-cluster connection is accepted
    Then both the inbound and outbound connection are "ACTIVE"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the "opensearch" "inbound connection" did not exist
    Given the "opensearch" "inbound connection" did not exist
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected

  @guard @negative @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected

  @guard @negative @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the "opensearch" "outbound connection" did not exist
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE"
    And the "opensearch" "outbound connection" did not exist
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected
