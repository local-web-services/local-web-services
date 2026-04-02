@opensearch @generated
Feature: Opensearch - An "Opensearch" "Inbound Connection" Is Rejected

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @reject_inbound_connection
  Scenario: an "opensearch" "inbound connection" is rejected
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE"
    And the "opensearch" "outbound connection" existed
    When an "opensearch" "inbound connection" is rejected
    Then both the inbound and outbound connection are "REJECTED"
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @reject_inbound_connection
  Scenario: an "opensearch" "inbound connection" is rejected fails when the "opensearch" "inbound connection" did not exist
    Given the "opensearch" "inbound connection" did not exist
    When an "opensearch" "inbound connection" is rejected
    Then the operation is rejected

  @guard @negative @reject_inbound_connection
  Scenario: an "opensearch" "inbound connection" is rejected fails when the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"
    When an "opensearch" "inbound connection" is rejected
    Then the operation is rejected

  @guard @negative @reject_inbound_connection
  Scenario: an "opensearch" "inbound connection" is rejected fails when the "opensearch" "outbound connection" did not exist
    Given the "opensearch" "inbound connection" existed
    And the "opensearch" "inbound connection" was "PENDING_ACCEPTANCE"
    And the "opensearch" "outbound connection" did not exist
    When an "opensearch" "inbound connection" is rejected
    Then the operation is rejected
