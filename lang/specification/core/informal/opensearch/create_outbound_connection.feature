@opensearch @generated
Feature: Opensearch - An Outbound Cross-Cluster Connection Is Created Between Two "Opensearch" "Domain"S

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was "ACTIVE"
    And the local and remote "opensearch" "domain"s are different
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the "opensearch" "connection" will be in "PENDING_ACCEPTANCE" state
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when no "opensearch" "connection" "slot" was "available"
    Given no "opensearch" "connection" "slot" was "available"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local "opensearch" "domain" did not exist
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" did not exist
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local "opensearch" "domain" was not "ACTIVE"
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was not "ACTIVE"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the remote "opensearch" "domain" did not exist
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" did not exist
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the remote "opensearch" "domain" was not "ACTIVE"
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was not "ACTIVE"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local and remote "opensearch" "domain"s are the same
    Given an "opensearch" "connection" "slot" was "available"
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was "ACTIVE"
    And the local and remote "opensearch" "domain"s are the same
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected
