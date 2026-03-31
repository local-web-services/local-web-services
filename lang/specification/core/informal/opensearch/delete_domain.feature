@opensearch @generated
Feature: Opensearch - An "Opensearch" "Domain" Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_domain
  Scenario: an "opensearch" "domain" is deleted
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "ACTIVE"
    When an "opensearch" "domain" is deleted
    Then the "opensearch" "domain" will be in "DELETING" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @delete_domain
  Scenario: an "opensearch" "domain" is deleted fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When an "opensearch" "domain" is deleted
    Then the operation is rejected

  @guard @negative @delete_domain @lifecycle
  Scenario: an "opensearch" "domain" is deleted fails when the "opensearch" "domain" was not "ACTIVE"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "ACTIVE"
    When an "opensearch" "domain" is deleted
    Then the operation is rejected
