@opensearch @generated
Feature: Opensearch - An Inbound Cross-Cluster Connection Is Accepted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted
    Given the inbound connection exists
    And the inbound connection is "PENDING_ACCEPTANCE"
    And the outbound connection exists
    When an inbound cross-cluster connection is accepted
    Then both the inbound and outbound connection are "ACTIVE"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the inbound connection does not exist
    Given the inbound connection does not exist
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected

  @standard @negative @internal @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the inbound connection is not "PENDING_ACCEPTANCE"
    Given the inbound connection exists
    And the inbound connection is not "PENDING_ACCEPTANCE"
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected

  @standard @negative @internal @accept_inbound_connection
  Scenario: an inbound cross-cluster connection is accepted fails when the outbound connection does not exist
    Given the inbound connection exists
    And the inbound connection is "PENDING_ACCEPTANCE"
    And the outbound connection does not exist
    When an inbound cross-cluster connection is accepted
    Then the operation is rejected
