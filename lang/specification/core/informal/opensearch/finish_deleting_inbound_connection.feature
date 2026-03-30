@opensearch @generated
Feature: Opensearch - An Inbound Connection Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_inbound_connection @internal
  Scenario: an inbound connection finishes deleting
    Given the inbound connection exists
    And the inbound connection is "DELETING"
    When an inbound connection finishes deleting
    Then the inbound connection is "DELETED"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @finish_deleting_inbound_connection @internal
  Scenario: an inbound connection finishes deleting fails when the inbound connection does not exist
    Given the inbound connection does not exist
    When an inbound connection finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_inbound_connection @internal
  Scenario: an inbound connection finishes deleting fails when the inbound connection is not "DELETING"
    Given the inbound connection exists
    And the inbound connection is not "DELETING"
    When an inbound connection finishes deleting
    Then the operation is rejected
