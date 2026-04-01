@opensearch @generated
Feature: Opensearch - Tags Are Added To An "Opensearch" "Domain"

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @add_tags
  Scenario: tags are added to an "opensearch" "domain"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is not being deleted
    And the "opensearch" "domain" was not "DELETED"
    When tags are added to an "opensearch" "domain"
    Then the specified tags are associated with the "opensearch" "domain"
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @add_tags
  Scenario: tags are added to an "opensearch" "domain" fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When tags are added to an "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @add_tags @lifecycle
  Scenario: tags are added to an "opensearch" "domain" fails when the "opensearch" "domain" is being deleted
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is being deleted
    When tags are added to an "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @add_tags
  Scenario: tags are added to an "opensearch" "domain" fails when the "opensearch" "domain" was "DELETED"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is not being deleted
    And the "opensearch" "domain" was "DELETED"
    When tags are added to an "opensearch" "domain"
    Then the operation is rejected
