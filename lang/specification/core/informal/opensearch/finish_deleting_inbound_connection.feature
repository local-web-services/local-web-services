@opensearch @generated
Feature: Opensearch - An "Opensearch" "Inbound Connection" Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_inbound_connection @internal
  Scenario: an "opensearch" "inbound connection" finishes deleting
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was "DELETING"
    When an "opensearch" "inbound connection" finishes deleting
    Then the "opensearch" "inbound connection" will be "DELETED"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @finish_deleting_inbound_connection @internal
  Scenario: an "opensearch" "inbound connection" finishes deleting fails when the "opensearch" "inbound connection" did not exist
    Given the "opensearch" "inbound connection" did not exist
    When an "opensearch" "inbound connection" finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_inbound_connection @internal
  Scenario: an "opensearch" "inbound connection" finishes deleting fails when the "opensearch" "inbound connection" was not "DELETING"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was not "DELETING"
    When an "opensearch" "inbound connection" finishes deleting
    Then the operation is rejected
