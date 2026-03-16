@opensearch @generated
Feature: Opensearch - A Search Domain Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_domain
  Scenario: a search domain is deleted
    Given the domain exists
    And the domain is "ACTIVE"
    When a search domain is deleted
    Then the domain is in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @delete_domain
  Scenario: a search domain is deleted fails when the domain does not exist
    Given the domain does not exist
    When a search domain is deleted
    Then the operation is rejected

  @standard @negative @delete_domain @lifecycle
  Scenario: a search domain is deleted fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a search domain is deleted
    Then the operation is rejected
