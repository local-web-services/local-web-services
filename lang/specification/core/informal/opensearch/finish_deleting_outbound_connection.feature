@opensearch @generated
Feature: Opensearch - An "Opensearch" "Outbound Connection" Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_outbound_connection @internal
  Scenario: an "opensearch" "outbound connection" finishes deleting
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" was "DELETING"
    And the associated "opensearch" "inbound connection" existed
    When an "opensearch" "outbound connection" finishes deleting
    Then the outbound and associated inbound connection will be "DELETED"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an "opensearch" "outbound connection" finishes deleting fails when the "opensearch" "outbound connection" did not exist
    Given the "opensearch" "outbound connection" did not exist
    When an "opensearch" "outbound connection" finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an "opensearch" "outbound connection" finishes deleting fails when the "opensearch" "outbound connection" was not "DELETING"
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" was not "DELETING"
    When an "opensearch" "outbound connection" finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_outbound_connection @internal
  Scenario: an "opensearch" "outbound connection" finishes deleting fails when the associated "opensearch" "inbound connection" did not exist
    Given the "opensearch" "outbound connection" existed
    And the "opensearch" "outbound connection" was "DELETING"
    And the associated "opensearch" "inbound connection" did not exist
    When an "opensearch" "outbound connection" finishes deleting
    Then the operation is rejected
