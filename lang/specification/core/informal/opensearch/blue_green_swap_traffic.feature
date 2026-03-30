@opensearch @generated
Feature: Opensearch - Traffic Is Swapped To The New Cluster During A Blue-Green Deployment

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new cluster during a blue-green deployment
    Given the domain exists
    And the domain is "PROCESSING"
    And the new cluster is ready
    And traffic has not been swapped yet
    When traffic is swapped to the new cluster during a blue-green deployment
    Then the domain is now serving requests from the new cluster
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new cluster during a blue-green deployment fails when the domain does not exist
    Given the domain does not exist
    When traffic is swapped to the new cluster during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new cluster during a blue-green deployment fails when the domain is not "PROCESSING"
    Given the domain exists
    And the domain is not "PROCESSING"
    When traffic is swapped to the new cluster during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new cluster during a blue-green deployment fails when the new cluster is not ready
    Given the domain exists
    And the domain is "PROCESSING"
    And the new cluster is not ready
    When traffic is swapped to the new cluster during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new cluster during a blue-green deployment fails when traffic has already been swapped
    Given the domain exists
    And the domain is "PROCESSING"
    And the new cluster is ready
    And traffic has already been swapped
    When traffic is swapped to the new cluster during a blue-green deployment
    Then the operation is rejected
