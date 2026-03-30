@opensearch @generated
Feature: Opensearch - A Search Domain Is Created

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: a search domain is created
    Given the domain does not already exist
    When a search domain is created
    Then the domain is in "CREATING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @create_domain
  Scenario: a search domain is created fails when the domain already exists
    Given the domain already exists
    When a search domain is created
    Then the operation is rejected
