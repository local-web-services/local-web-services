@opensearch @generated
Feature: Opensearch - Tags Are Removed From An "Opensearch" "Domain"

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @remove_tags
  Scenario: tags are removed from an "opensearch" "domain"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is not being deleted
    And the "opensearch" "domain" was not "DELETED"
    And the "opensearch" "tag key" existed
    When tags are removed from an "opensearch" "domain"
    Then the specified tags are no longer associated with the "opensearch" "domain"
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @remove_tags
  Scenario: tags are removed from an "opensearch" "domain" fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When tags are removed from an "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @remove_tags @lifecycle
  Scenario: tags are removed from an "opensearch" "domain" fails when the "opensearch" "domain" is being deleted
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is being deleted
    When tags are removed from an "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @remove_tags
  Scenario: tags are removed from an "opensearch" "domain" fails when the "opensearch" "domain" was "DELETED"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is not being deleted
    And the "opensearch" "domain" was "DELETED"
    When tags are removed from an "opensearch" "domain"
    Then the operation is rejected

  @guard @negative @remove_tags
  Scenario: tags are removed from an "opensearch" "domain" fails when the "opensearch" "tag key" did not exist
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" is not being deleted
    And the "opensearch" "domain" was not "DELETED"
    And the "opensearch" "tag key" did not exist
    When tags are removed from an "opensearch" "domain"
    Then the operation is rejected
