@opensearch @generated
Feature: Opensearch - The New Cluster For A Blue-Green Deployment Becomes Ready

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @blue_green_new_cluster_ready @internal
  Scenario: the new cluster for a blue-green deployment becomes ready
    Given the domain exists
    And the domain is "PROCESSING"
    And the new cluster has not been prepared yet
    When the new cluster for a blue-green deployment becomes ready
    Then the domain has a new cluster prepared but traffic is not yet swapped
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new cluster for a blue-green deployment becomes ready fails when the domain does not exist
    Given the domain does not exist
    When the new cluster for a blue-green deployment becomes ready
    Then the operation is rejected

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new cluster for a blue-green deployment becomes ready fails when the domain is not "PROCESSING"
    Given the domain exists
    And the domain is not "PROCESSING"
    When the new cluster for a blue-green deployment becomes ready
    Then the operation is rejected

  @guard @negative @blue_green_new_cluster_ready @internal
  Scenario: the new cluster for a blue-green deployment becomes ready fails when the new cluster has already been prepared
    Given the domain exists
    And the domain is "PROCESSING"
    And the new cluster has already been prepared
    When the new cluster for a blue-green deployment becomes ready
    Then the operation is rejected
