@opensearch @generated
Feature: Opensearch - An "Opensearch" "Domain" Is Created

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an "opensearch" "domain" is created
    Given the "opensearch" "domain" did not already exist
    When an "opensearch" "domain" is created
    Then the "opensearch" "domain" will be in "CREATING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @create_domain
  Scenario: an "opensearch" "domain" is created fails when the "opensearch" "domain" already existed
    Given the "opensearch" "domain" already existed
    When an "opensearch" "domain" is created
    Then the operation is rejected
