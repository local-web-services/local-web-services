@opensearch @generated
Feature: Opensearch - Traffic Is Swapped To The New "Opensearch" "Cluster" During A Blue-Green Deployment

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And the new "opensearch" "cluster" was ready
    And traffic has not been swapped yet
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Then the "opensearch" "domain" will now be serving requests from the new "opensearch" "cluster"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment fails when the "opensearch" "domain" was not "PROCESSING"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "PROCESSING"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment fails when the new "opensearch" "cluster" was not ready
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And the new "opensearch" "cluster" was not ready
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Then the operation is rejected

  @guard @negative @blue_green_swap_traffic @internal
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment fails when traffic has already been swapped
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And the new "opensearch" "cluster" was ready
    And traffic has already been swapped
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Then the operation is rejected
