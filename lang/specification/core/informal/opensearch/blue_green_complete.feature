@opensearch @generated
Feature: Opensearch - A "Opensearch" "Domain" Blue-Green Deployment Completes

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_complete @internal
  Scenario: a "opensearch" "domain" blue-green deployment completes
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And traffic has been swapped to the new "opensearch" "cluster"
    When a "opensearch" "domain" blue-green deployment completes
    Then the "opensearch" "domain" will be "ACTIVE" with the new configuration applied
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @blue_green_complete @internal
  Scenario: a "opensearch" "domain" blue-green deployment completes fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When a "opensearch" "domain" blue-green deployment completes
    Then the operation is rejected

  @guard @negative @blue_green_complete @internal
  Scenario: a "opensearch" "domain" blue-green deployment completes fails when the "opensearch" "domain" was not "PROCESSING"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "PROCESSING"
    When a "opensearch" "domain" blue-green deployment completes
    Then the operation is rejected

  @guard @negative @blue_green_complete @internal
  Scenario: a "opensearch" "domain" blue-green deployment completes fails when traffic has not been swapped to the new "opensearch" "cluster"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And traffic has not been swapped to the new "opensearch" "cluster"
    When a "opensearch" "domain" blue-green deployment completes
    Then the operation is rejected
