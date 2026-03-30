@opensearch @generated
Feature: Opensearch - A Search Domain Finishes Deleting

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting
    Given the domain exists
    And the domain is "DELETING"
    When a search domain finishes deleting
    Then the domain is "DELETED" and all associated connections are removed
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting fails when the domain does not exist
    Given the domain does not exist
    When a search domain finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting fails when the domain is not "DELETING"
    Given the domain exists
    And the domain is not "DELETING"
    When a search domain finishes deleting
    Then the operation is rejected
