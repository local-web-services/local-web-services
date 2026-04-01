@opensearch @generated
Feature: Opensearch - The New "Opensearch" "Cluster" For A Blue-Green Deployment Becomes Ready

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_new_cluster_ready @internal
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And the new "opensearch" "cluster" has not been prepared yet
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Then the "opensearch" "domain" will have a new cluster prepared but traffic will not yet be swapped
    And no active "opensearch" "connection" references a deleted "opensearch" "domain"
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" "opensearch" "inbound connection"
    And a pending config change only exists on an "opensearch" "domain" that is "PROCESSING"

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready fails when the "opensearch" "domain" did not exist
    Given the "opensearch" "domain" did not exist
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Then the operation is rejected

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready fails when the "opensearch" "domain" was not "PROCESSING"
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was not "PROCESSING"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Then the operation is rejected

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready fails when the new "opensearch" "cluster" has already been prepared
    Given the "opensearch" "domain" existed
    And the "opensearch" "domain" was "PROCESSING"
    And the new "opensearch" "cluster" has already been prepared
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Then the operation is rejected
