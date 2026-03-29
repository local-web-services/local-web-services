@opensearch @generated
Feature: Opensearch - An Outbound Cross-Cluster Connection Is Created Between Two Domains

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two domains
    Given the connection slot is available
    And the local domain exists
    And the local domain is "ACTIVE"
    And the remote domain exists
    And the remote domain is "ACTIVE"
    And the local and remote domains are different
    When an outbound cross-cluster connection is created between two domains
    Then the connection is in "PENDING_ACCEPTANCE" state
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @internal @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two domains fails when the connection slot is not available
    Given the connection slot is not available
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected

  @standard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two domains fails when the local domain does not exist
    Given the connection slot is available
    And the local domain does not exist
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected

  @standard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two domains fails when the local domain is not "ACTIVE"
    Given the connection slot is available
    And the local domain exists
    And the local domain is not "ACTIVE"
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected

  @standard @negative @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two domains fails when the remote domain does not exist
    Given the connection slot is available
    And the local domain exists
    And the local domain is "ACTIVE"
    And the remote domain does not exist
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected

  @standard @negative @create_outbound_connection @lifecycle
  Scenario: an outbound cross-cluster connection is created between two domains fails when the remote domain is not "ACTIVE"
    Given the connection slot is available
    And the local domain exists
    And the local domain is "ACTIVE"
    And the remote domain exists
    And the remote domain is not "ACTIVE"
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected

  @standard @negative @internal @create_outbound_connection
  Scenario: an outbound cross-cluster connection is created between two domains fails when the local and remote domains are the same
    Given the connection slot is available
    And the local domain exists
    And the local domain is "ACTIVE"
    And the remote domain exists
    And the remote domain is "ACTIVE"
    And the local and remote domains are the same
    When an outbound cross-cluster connection is created between two domains
    Then the operation is rejected
