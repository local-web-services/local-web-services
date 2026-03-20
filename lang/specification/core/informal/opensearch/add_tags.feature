@opensearch @generated
Feature: Opensearch - Tags Are Added To A Domain

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @add_tags
  Scenario: tags are added to a domain
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    When tags are added to a domain
    Then the specified tags are associated with the domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @add_tags
  Scenario: tags are added to a domain fails when the domain does not exist
    Given the domain does not exist
    When tags are added to a domain
    Then the operation is rejected

  @standard @negative @add_tags @lifecycle
  Scenario: tags are added to a domain fails when the domain is being deleted
    Given the domain exists
    And the domain is being deleted
    When tags are added to a domain
    Then the operation is rejected

  @standard @negative @add_tags
  Scenario: tags are added to a domain fails when the domain is deleted
    Given the domain exists
    And the domain is not being deleted
    And the domain is deleted
    When tags are added to a domain
    Then the operation is rejected
