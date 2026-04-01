@opensearch @generated
Feature: Opensearch - An "Opensearch" "Domain" Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_domain @internal
  Scenario: an "opensearch" "domain" finishes deleting
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "DELETING"
    When an "opensearch" "domain" finishes deleting
    Then the "opensearch" "domain" will be "DELETED" and all associated connections will be removed
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @finish_deleting_domain @internal
  Scenario: an "opensearch" "domain" finishes deleting fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When an "opensearch" "domain" finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_domain @internal
  Scenario: an "opensearch" "domain" finishes deleting fails when the "opensearch" "domain" was not "DELETING"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "DELETING"
    When an "opensearch" "domain" finishes deleting
    Then the operation is rejected
