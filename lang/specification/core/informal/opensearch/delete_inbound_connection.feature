@opensearch @generated
Feature: Opensearch - An Inbound Cross-Cluster Connection Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted
    Given the inbound connection exists
    And the inbound connection is not already "DELETING"
    And the inbound connection is not already "DELETED"
    When an inbound cross-cluster connection is deleted
    Then the inbound connection is in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the inbound connection does not exist
    Given the inbound connection does not exist
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @internal @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the inbound connection is already "DELETING"
    Given the inbound connection exists
    And the inbound connection is already "DELETING"
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected

  @guard @negative @internal @delete_inbound_connection
  Scenario: an inbound cross-cluster connection is deleted fails when the inbound connection is already "DELETED"
    Given the inbound connection exists
    And the inbound connection is not already "DELETING"
    And the inbound connection is already "DELETED"
    When an inbound cross-cluster connection is deleted
    Then the operation is rejected
