@opensearch @generated
Feature: Opensearch - An Outbound Cross-Cluster Connection Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted
    Given the outbound connection exists
    And the outbound connection is not already "DELETING"
    And the outbound connection is not already "DELETED"
    When an outbound cross-cluster connection is deleted
    Then the outbound connection is in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the outbound connection does not exist
    Given the outbound connection does not exist
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected

  @standard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the outbound connection is already "DELETING"
    Given the outbound connection exists
    And the outbound connection is already "DELETING"
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected

  @standard @negative @delete_outbound_connection
  Scenario: an outbound cross-cluster connection is deleted fails when the outbound connection is already "DELETED"
    Given the outbound connection exists
    And the outbound connection is not already "DELETING"
    And the outbound connection is already "DELETED"
    When an outbound cross-cluster connection is deleted
    Then the operation is rejected
