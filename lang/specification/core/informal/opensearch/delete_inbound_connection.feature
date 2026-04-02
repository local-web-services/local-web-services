@opensearch @generated
Feature: Opensearch - An "Opensearch" "Inbound Connection" Is Deleted

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_inbound_connection
  Scenario: an "opensearch" "inbound connection" is deleted
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is not already "DELETING"
    And the "opensearch" "inbound connection" is not already "DELETED"
    When an "opensearch" "inbound connection" is deleted
    Then the "opensearch" "inbound connection" will be in "DELETING" state
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @delete_inbound_connection
  Scenario: an "opensearch" "inbound connection" is deleted fails when the "opensearch" "inbound connection" did not exist
    Given the "opensearch" "inbound connection" did not exist
    When an "opensearch" "inbound connection" is deleted
    Then the operation is rejected

  @guard @negative @delete_inbound_connection
  Scenario: an "opensearch" "inbound connection" is deleted fails when the "opensearch" "inbound connection" is already "DELETING"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is already "DELETING"
    When an "opensearch" "inbound connection" is deleted
    Then the operation is rejected

  @guard @negative @delete_inbound_connection
  Scenario: an "opensearch" "inbound connection" is deleted fails when the "opensearch" "inbound connection" is already "DELETED"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" is not already "DELETING"
    And the "opensearch" "inbound connection" is already "DELETED"
    When an "opensearch" "inbound connection" is deleted
    Then the operation is rejected
