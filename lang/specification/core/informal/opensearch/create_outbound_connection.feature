@opensearch @generated
Feature: Opensearch - An Outbound Cross-Cluster Connection Is Created Between Two "Opensearch" "Domain"S

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given the connection slot is available
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was "ACTIVE"
    And the local and remote domains are different
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the connection will be in "PENDING_ACCEPTANCE" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the connection slot is not available
    Given the connection slot is not available
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local "opensearch" "domain" did not exist
    Given the connection slot is available
    And the local "opensearch" "domain" did not exist
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local "opensearch" "domain" was not "ACTIVE"
    Given the connection slot is available
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was not "ACTIVE"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the remote "opensearch" "domain" did not exist
    Given the connection slot is available
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" did not exist
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the remote "opensearch" "domain" was not "ACTIVE"
    Given the connection slot is available
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was not "ACTIVE"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected

  @guard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s fails when the local and remote domains are the same
    Given the connection slot is available
    And the local "opensearch" "domain" existed
    And the local "opensearch" "domain" was "ACTIVE"
    And the remote "opensearch" "domain" existed
    And the remote "opensearch" "domain" was "ACTIVE"
    And the local and remote domains are the same
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Then the operation is rejected
