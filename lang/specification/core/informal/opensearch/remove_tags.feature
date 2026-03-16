@opensearch @generated
Feature: Opensearch - Tags Are Removed From A Domain

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @remove_tags
  Scenario: tags are removed from a domain
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    And the tag key exists
    When tags are removed from a domain
    Then the specified tags are no longer associated with the domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the domain does not exist
    Given the domain does not exist
    When tags are removed from a domain
    Then the operation is rejected

  @standard @negative @remove_tags @lifecycle
  Scenario: tags are removed from a domain fails when the domain is being deleted
    Given the domain exists
    And the domain is being deleted
    When tags are removed from a domain
    Then the operation is rejected

  @standard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the domain is deleted
    Given the domain exists
    And the domain is not being deleted
    And the domain is deleted
    When tags are removed from a domain
    Then the operation is rejected

  @standard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the tag key does not exist
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    And the tag key does not exist
    When tags are removed from a domain
    Then the operation is rejected
