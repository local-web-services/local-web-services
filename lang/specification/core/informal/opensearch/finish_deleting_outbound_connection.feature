@opensearch @generated
Feature: Opensearch - An Outbound Connection Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_outbound_connection @internal
  Scenario: an outbound connection finishes deleting
    Given the outbound connection exists
    And the outbound connection is "DELETING"
    And the associated inbound connection exists
    When an outbound connection finishes deleting
    Then the outbound and associated inbound connection are "DELETED"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an outbound connection finishes deleting fails when the outbound connection does not exist
    Given the outbound connection does not exist
    When an outbound connection finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an outbound connection finishes deleting fails when the outbound connection is not "DELETING"
    Given the outbound connection exists
    And the outbound connection is not "DELETING"
    When an outbound connection finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an outbound connection finishes deleting fails when the associated inbound connection does not exist
    Given the outbound connection exists
    And the outbound connection is "DELETING"
    And the associated inbound connection does not exist
    When an outbound connection finishes deleting
    Then the operation is rejected
