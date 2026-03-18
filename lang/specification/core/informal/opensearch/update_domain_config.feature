@opensearch @generated
Feature: Opensearch - A Domain Configuration Update Is Requested

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @update_domain_config
  Scenario: a domain configuration update is requested
    Given the domain exists
    And the domain is "ACTIVE"
    When a domain configuration update is requested
    Then the domain is in "PROCESSING" state and a blue-green deployment begins
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @update_domain_config
  Scenario: a domain configuration update is requested fails when the domain does not exist
    Given the domain does not exist
    When a domain configuration update is requested
    Then the operation is rejected

  @standard @negative @update_domain_config @lifecycle @internal
  Scenario: a domain configuration update is requested fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a domain configuration update is requested
    Then the operation is rejected
