@opensearch @generated
Feature: Opensearch - An "Opensearch" "Domain" Configuration Update Is Requested

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @update_domain_config
  Scenario: an "opensearch" "domain" configuration update is requested
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    When an "opensearch" "domain" configuration update is requested
    Then the "opensearch" "domain" will be in "PROCESSING" state and a blue-green deployment begins
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @update_domain_config
  Scenario: an "opensearch" "domain" configuration update is requested fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When an "opensearch" "domain" configuration update is requested
    Then the operation is rejected

  @guard @negative @update_domain_config @lifecycle
  Scenario: an "opensearch" "domain" configuration update is requested fails when the "opensearch" "domain" was not "ACTIVE"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "ACTIVE"
    When an "opensearch" "domain" configuration update is requested
    Then the operation is rejected
