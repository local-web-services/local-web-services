@opensearch @generated
Feature: Opensearch - A Blue-Green Deployment Completes

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_complete @internal
  Scenario: a blue-green deployment completes
    Given the domain exists
    And the domain is "PROCESSING"
    And traffic has been swapped to the new cluster
    When a blue-green deployment completes
    Then the domain is "ACTIVE" with the new configuration applied
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @blue_green_complete @internal
  Scenario: a blue-green deployment completes fails when the domain does not exist
    Given the domain does not exist
    When a blue-green deployment completes
    Then the operation is rejected

  @guard @negative @blue_green_complete @internal
  Scenario: a blue-green deployment completes fails when the domain is not "PROCESSING"
    Given the domain exists
    And the domain is not "PROCESSING"
    When a blue-green deployment completes
    Then the operation is rejected

  @guard @negative @blue_green_complete @internal
  Scenario: a blue-green deployment completes fails when traffic has not been swapped to the new cluster
    Given the domain exists
    And the domain is "PROCESSING"
    And traffic has not been swapped to the new cluster
    When a blue-green deployment completes
    Then the operation is rejected
