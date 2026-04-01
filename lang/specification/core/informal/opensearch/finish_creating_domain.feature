@opensearch @generated
Feature: Opensearch - An "Opensearch" "Domain" Finishes Creating

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_domain @internal
  Scenario: an "opensearch" "domain" finishes creating
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "CREATING"
    When an "opensearch" "domain" finishes creating
    Then the "opensearch" "domain" will be "ACTIVE" and ready for use
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @finish_creating_domain @internal
  Scenario: an "opensearch" "domain" finishes creating fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When an "opensearch" "domain" finishes creating
    Then the operation is rejected

  @guard @negative @finish_creating_domain @internal
  Scenario: an "opensearch" "domain" finishes creating fails when the "opensearch" "domain" was not "CREATING"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "CREATING"
    When an "opensearch" "domain" finishes creating
    Then the operation is rejected
