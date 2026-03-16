@opensearch @generated
Feature: Opensearch - A Search Domain Finishes Creating

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_domain @internal
  Scenario: a search domain finishes creating
    Given the domain exists
    And the domain is "CREATING"
    When a search domain finishes creating
    Then the domain is "ACTIVE" and ready for use
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @finish_creating_domain @internal
  Scenario: a search domain finishes creating fails when the domain does not exist
    Given the domain does not exist
    When a search domain finishes creating
    Then the operation is rejected

  @standard @negative @finish_creating_domain @internal
  Scenario: a search domain finishes creating fails when the domain is not "CREATING"
    Given the domain exists
    And the domain is not "CREATING"
    When a search domain finishes creating
    Then the operation is rejected
