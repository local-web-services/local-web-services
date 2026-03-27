@opensearch @generated
Feature: Opensearch - Action Sequences

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes creating
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain is deleted
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a domain configuration update is requested
    Given domain not in domain_status
    Given a search domain has been created
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then the new cluster for a blue-green deployment becomes ready
    Given domain not in domain_status
    Given a search domain has been created
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then traffic is swapped to the new cluster during a blue-green deployment
    Given domain not in domain_status
    Given a search domain has been created
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a blue-green deployment completes
    Given domain not in domain_status
    Given a search domain has been created
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then shards are rebalanced across nodes in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is created between two domains
    Given domain not in domain_status
    Given a search domain has been created
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    Given a search domain has been created
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    Given a search domain has been created
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    Given a search domain has been created
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound connection finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    Given a search domain has been created
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound connection finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are added to a domain
    Given domain not in domain_status
    Given a search domain has been created
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are removed from a domain
    Given domain not in domain_status
    Given a search domain has been created
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is created
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished creating
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has finished creating
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has finished creating
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has finished creating
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has finished creating
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has finished creating
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has finished creating
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished creating
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished creating
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain is created
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has been deleted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has been deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has been deleted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has been deleted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has been deleted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has been deleted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are added to a domain
    Given domain in domain_status
    Given a search domain has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is created
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has finished deleting
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has finished deleting
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished deleting
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished deleting
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is created
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a domain configuration update has been requested
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a domain configuration update has been requested
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound connection finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound connection finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is created
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes creating
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are added to a domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are removed from a domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is created
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound connection finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is created
    Given domain in domain_status
    Given a blue-green deployment has completed
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes creating
    Given domain in domain_status
    Given a blue-green deployment has completed
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a domain configuration update is requested
    Given domain in domain_status
    Given a blue-green deployment has completed
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a blue-green deployment has completed
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a blue-green deployment has completed
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound connection finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound connection finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are added to a domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are removed from a domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is created
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a blue-green deployment completes
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are added to a domain
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is created
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes creating
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a domain configuration update is requested
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a blue-green deployment completes
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are added to a domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are removed from a domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is created
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes creating
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is deleted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to a domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from a domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is created
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes creating
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes deleting
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a domain configuration update is requested
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a blue-green deployment completes
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are added to a domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are removed from a domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is created
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are added to a domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is created
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been added to a domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given tags have been added to a domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given tags have been added to a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a blue-green deployment completes
    Given domain in domain_status
    Given tags have been added to a domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given tags have been added to a domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given tags have been added to a domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given tags have been added to a domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound connection finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound connection finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then tags are removed from a domain
    Given domain in domain_status
    Given tags have been added to a domain
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is created
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been removed from a domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given tags have been removed from a domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given tags have been removed from a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a blue-green deployment completes
    Given domain in domain_status
    Given tags have been removed from a domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given tags have been removed from a domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound connection finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound connection finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then tags are added to a domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes creating then a search domain is deleted
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has finished creating
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain is deleted then a search domain finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes deleting then a domain configuration update is requested
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain not in domain_status
    Given a search domain has been created
    Given a domain configuration update has been requested
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain not in domain_status
    Given a search domain has been created
    Given the new cluster for a blue-green deployment has become ready
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain not in domain_status
    Given a search domain has been created
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given a blue-green deployment has completed
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain not in domain_status
    Given a search domain has been created
    Given shards have been rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    Given a search domain has been created
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    Given a search domain has been created
    Given an inbound cross-cluster connection has been accepted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    Given a search domain has been created
    Given an inbound cross-cluster connection has been rejected
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    Given an outbound cross-cluster connection has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    Given a search domain has been created
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    Given an inbound cross-cluster connection has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound connection finishes deleting then tags are added to a domain
    Given domain not in domain_status
    Given a search domain has been created
    Given an inbound connection has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are added to a domain then tags are removed from a domain
    Given domain not in domain_status
    Given a search domain has been created
    Given tags have been added to a domain
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are removed from a domain then a search domain finishes creating
    Given domain not in domain_status
    Given a search domain has been created
    Given tags have been removed from a domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is created then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has been created
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has finished creating
    Given a domain configuration update has been requested
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has finished creating
    Given the new cluster for a blue-green deployment has become ready
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has finished creating
    Given a blue-green deployment has completed
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has finished creating
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has finished creating
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    Given an inbound cross-cluster connection has been accepted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    Given an inbound cross-cluster connection has been rejected
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound connection finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    Given an outbound connection has finished deleting
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given an inbound cross-cluster connection has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given an inbound connection has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are added to a domain then a search domain is created
    Given domain in domain_status
    Given a search domain has finished creating
    Given tags have been added to a domain
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    Given tags have been removed from a domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain is created then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has been created
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes creating then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has finished creating
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has been deleted
    Given a domain configuration update has been requested
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given the new cluster for a blue-green deployment has become ready
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has been deleted
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has been deleted
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has been deleted
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has been deleted
    Given an outbound cross-cluster connection has been created between two domains
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is accepted then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    Given an inbound cross-cluster connection has been accepted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has been deleted
    Given an inbound cross-cluster connection has been rejected
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    Given an outbound cross-cluster connection has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound connection finishes deleting then tags are added to a domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given an outbound connection has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is deleted then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given an inbound cross-cluster connection has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    Given a search domain has been deleted
    Given an inbound connection has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has been deleted
    Given tags have been added to a domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    Given tags have been removed from a domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is created then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has been created
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has finished creating
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted then a blue-green deployment completes
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has been deleted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a domain configuration update has been requested
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a search domain has finished deleting
    Given the new cluster for a blue-green deployment has become ready
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a search domain has finished deleting
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    Given shards have been rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an outbound cross-cluster connection has been created between two domains
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an inbound cross-cluster connection has been accepted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is rejected then an inbound connection finishes deleting
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an inbound cross-cluster connection has been rejected
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an outbound cross-cluster connection has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an outbound connection has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is deleted then a search domain is created
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an inbound cross-cluster connection has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound connection finishes deleting then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an inbound connection has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    Given tags have been added to a domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished deleting
    Given tags have been removed from a domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is created then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has been created
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating then a blue-green deployment completes
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has finished creating
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has been deleted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has finished deleting
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given the new cluster for a blue-green deployment has become ready
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a blue-green deployment has completed
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given shards have been rebalanced across nodes in an active domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is accepted then an inbound connection finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an inbound cross-cluster connection has been accepted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is rejected then tags are added to a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an inbound cross-cluster connection has been rejected
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is deleted then tags are removed from a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an outbound cross-cluster connection has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an outbound connection has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is deleted then a search domain finishes creating
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an inbound cross-cluster connection has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound connection finishes deleting then a search domain is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an inbound connection has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given tags have been added to a domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given tags have been removed from a domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is created then a blue-green deployment completes
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a search domain has been created
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes creating then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a search domain has finished creating
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is deleted then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a search domain has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a domain configuration update has been requested
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes then an outbound connection finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given a blue-green deployment has completed
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted then tags are added to a domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an inbound cross-cluster connection has been accepted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected then tags are removed from a domain
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an inbound cross-cluster connection has been rejected
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted then a search domain is created
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an outbound cross-cluster connection has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting then a search domain finishes creating
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an outbound connection has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted then a search domain is deleted
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an inbound cross-cluster connection has been deleted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting then a search domain finishes deleting
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given an inbound connection has finished deleting
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given tags have been added to a domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given the new cluster for a blue-green deployment has become ready
    Given tags have been removed from a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is created then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a search domain has been created
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a search domain has finished creating
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a search domain has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a domain configuration update has been requested
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given the new cluster for a blue-green deployment has become ready
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given a blue-green deployment has completed
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given shards have been rebalanced across nodes in an active domain
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains then tags are added to a domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an outbound cross-cluster connection has been created between two domains
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted then tags are removed from a domain
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an inbound cross-cluster connection has been accepted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected then a search domain is created
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an inbound cross-cluster connection has been rejected
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted then a search domain finishes creating
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an outbound cross-cluster connection has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound connection finishes deleting then a search domain is deleted
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an outbound connection has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an inbound cross-cluster connection has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given an inbound connection has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given tags have been added to a domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain then a blue-green deployment completes
    Given domain in domain_status
    Given traffic has been swapped to the new cluster during a blue-green deployment
    Given tags have been removed from a domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is created then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given a search domain has been created
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given a search domain has finished creating
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given a search domain has been deleted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given a search domain has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a domain configuration update is requested then an outbound connection finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given a domain configuration update has been requested
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given the new cluster for a blue-green deployment has become ready
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active domain then tags are added to a domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given shards have been rebalanced across nodes in an active domain
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two domains then tags are removed from a domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an outbound cross-cluster connection has been created between two domains
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted then a search domain is created
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an inbound cross-cluster connection has been accepted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected then a search domain finishes creating
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an inbound cross-cluster connection has been rejected
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted then a search domain is deleted
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an outbound cross-cluster connection has been deleted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound connection finishes deleting then a search domain finishes deleting
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an outbound connection has finished deleting
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an inbound cross-cluster connection has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given an inbound connection has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given tags have been added to a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are removed from a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given a blue-green deployment has completed
    Given tags have been removed from a domain
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is created then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a search domain has been created
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a search domain has finished creating
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a search domain has been deleted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes deleting then an outbound connection finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a search domain has finished deleting
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a domain configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a domain configuration update has been requested
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given the new cluster for a blue-green deployment has become ready
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a blue-green deployment completes then tags are removed from a domain
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given a blue-green deployment has completed
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains then a search domain is created
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted then a search domain finishes creating
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an inbound cross-cluster connection has been accepted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected then a search domain is deleted
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an inbound cross-cluster connection has been rejected
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an outbound cross-cluster connection has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an outbound connection has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an inbound cross-cluster connection has been deleted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given an inbound connection has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are added to a domain then a blue-green deployment completes
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given tags have been added to a domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are removed from a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given shards have been rebalanced across nodes in an active domain
    Given tags have been removed from a domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is created then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a search domain has been created
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes creating then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a search domain has finished creating
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is deleted then an outbound connection finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a search domain has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes deleting then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a search domain has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a domain configuration update is requested then an inbound connection finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a domain configuration update has been requested
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready then tags are added to a domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given the new cluster for a blue-green deployment has become ready
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a blue-green deployment completes then a search domain is created
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given a blue-green deployment has completed
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain then a search domain finishes creating
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given shards have been rebalanced across nodes in an active domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted then a search domain is deleted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an inbound cross-cluster connection has been accepted
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected then a search domain finishes deleting
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an inbound cross-cluster connection has been rejected
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an outbound cross-cluster connection has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an outbound connection has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an inbound cross-cluster connection has been deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting then a blue-green deployment completes
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given an inbound connection has finished deleting
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are added to a domain then shards are rebalanced across nodes in an active domain
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given tags have been added to a domain
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are removed from a domain then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    Given an outbound cross-cluster connection has been created between two domains
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is created then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a search domain has been created
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes creating then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a search domain has finished creating
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is deleted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a search domain has been deleted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes deleting then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a search domain has finished deleting
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a domain configuration update is requested then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a domain configuration update has been requested
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given the new cluster for a blue-green deployment has become ready
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given a blue-green deployment has completed
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given shards have been rebalanced across nodes in an active domain
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an outbound cross-cluster connection has been created between two domains
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an inbound cross-cluster connection has been rejected
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an outbound cross-cluster connection has been deleted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an outbound connection has finished deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an inbound cross-cluster connection has been deleted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given an inbound connection has finished deleting
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to a domain then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given tags have been added to a domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from a domain then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been accepted
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is created then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a search domain has been created
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes creating then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a search domain has finished creating
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is deleted then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a search domain has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes deleting then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a search domain has finished deleting
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a domain configuration update is requested then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a domain configuration update has been requested
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new cluster for a blue-green deployment becomes ready then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given the new cluster for a blue-green deployment has become ready
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given a blue-green deployment has completed
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given shards have been rebalanced across nodes in an active domain
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an outbound cross-cluster connection has been created between two domains
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an inbound cross-cluster connection has been accepted
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an outbound cross-cluster connection has been deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound connection finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an outbound connection has finished deleting
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an inbound cross-cluster connection has been deleted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given an inbound connection has finished deleting
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to a domain then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given tags have been added to a domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from a domain then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been rejected
    Given tags have been removed from a domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is created then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a search domain has been created
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes creating then an inbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a search domain has finished creating
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is deleted then tags are added to a domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a search domain has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes deleting then tags are removed from a domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a search domain has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a domain configuration update is requested then a search domain is created
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a domain configuration update has been requested
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready then a search domain finishes creating
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given the new cluster for a blue-green deployment has become ready
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes then a search domain finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given a blue-green deployment has completed
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain then a domain configuration update is requested
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given shards have been rebalanced across nodes in an active domain
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an outbound cross-cluster connection has been created between two domains
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an inbound cross-cluster connection has been accepted
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an inbound cross-cluster connection has been rejected
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an outbound connection has finished deleting
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an inbound cross-cluster connection has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given an inbound connection has finished deleting
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to a domain then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given tags have been added to a domain
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from a domain then an outbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound cross-cluster connection has been deleted
    Given tags have been removed from a domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is created then an inbound connection finishes deleting
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a search domain has been created
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes creating then tags are added to a domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a search domain has finished creating
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is deleted then tags are removed from a domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a search domain has been deleted
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes deleting then a search domain is created
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a search domain has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a domain configuration update is requested then a search domain finishes creating
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a domain configuration update has been requested
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready then a search domain is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given the new cluster for a blue-green deployment has become ready
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a blue-green deployment completes then a domain configuration update is requested
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given a blue-green deployment has completed
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given shards have been rebalanced across nodes in an active domain
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an outbound cross-cluster connection has been created between two domains
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an inbound cross-cluster connection has been accepted
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an inbound cross-cluster connection has been rejected
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an outbound cross-cluster connection has been deleted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an inbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given an inbound connection has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are added to a domain then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given tags have been added to a domain
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are removed from a domain then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    Given an outbound connection has finished deleting
    Given tags have been removed from a domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is created then tags are added to a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a search domain has been created
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes creating then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a search domain has finished creating
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is deleted then a search domain is created
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a search domain has been deleted
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes deleting then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a search domain has finished deleting
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a domain configuration update is requested then a search domain is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a domain configuration update has been requested
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given the new cluster for a blue-green deployment has become ready
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given a blue-green deployment has completed
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given shards have been rebalanced across nodes in an active domain
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an outbound cross-cluster connection has been created between two domains
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an inbound cross-cluster connection has been accepted
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an inbound cross-cluster connection has been rejected
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given an inbound connection has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to a domain then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given tags have been added to a domain
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from a domain then an inbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound cross-cluster connection has been deleted
    Given tags have been removed from a domain
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is created then tags are removed from a domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a search domain has been created
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes creating then a search domain is created
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a search domain has finished creating
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is deleted then a search domain finishes creating
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a search domain has been deleted
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes deleting then a search domain is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a search domain has finished deleting
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a domain configuration update is requested then a search domain finishes deleting
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a domain configuration update has been requested
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given the new cluster for a blue-green deployment has become ready
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given a blue-green deployment has completed
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain then a blue-green deployment completes
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given shards have been rebalanced across nodes in an active domain
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an outbound cross-cluster connection has been created between two domains
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an inbound cross-cluster connection has been accepted
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an inbound cross-cluster connection has been rejected
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an outbound connection has finished deleting
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given an inbound cross-cluster connection has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are added to a domain then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given tags have been added to a domain
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are removed from a domain then tags are added to a domain
    Given conn in inbound_status
    Given an inbound connection has finished deleting
    Given tags have been removed from a domain
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is created then a search domain finishes creating
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has been created
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has finished creating
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given tags have been added to a domain
    Given a domain configuration update has been requested
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given tags have been added to a domain
    Given the new cluster for a blue-green deployment has become ready
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    Given tags have been added to a domain
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a blue-green deployment has completed
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given tags have been added to a domain
    Given shards have been rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given tags have been added to a domain
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given tags have been added to a domain
    Given an inbound cross-cluster connection has been accepted
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    Given an inbound cross-cluster connection has been rejected
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    Given an outbound cross-cluster connection has been deleted
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    Given an outbound connection has finished deleting
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    Given an inbound cross-cluster connection has been deleted
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given an inbound connection has finished deleting
    When tags are removed from a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then tags are removed from a domain then a search domain is created
    Given domain in domain_status
    Given tags have been added to a domain
    Given tags have been removed from a domain
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is created then a search domain is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has been created
    When a search domain is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has finished creating
    When a search domain finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has finished deleting
    When the new cluster for a blue-green deployment becomes ready
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a domain configuration update has been requested
    When traffic is swapped to the new cluster during a blue-green deployment
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    Given tags have been removed from a domain
    Given the new cluster for a blue-green deployment has become ready
    When a blue-green deployment completes
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given traffic has been swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a blue-green deployment has completed
    When an outbound cross-cluster connection is created between two domains
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    Given tags have been removed from a domain
    Given shards have been rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an outbound cross-cluster connection has been created between two domains
    When an inbound cross-cluster connection is rejected
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an inbound cross-cluster connection has been accepted
    When an outbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an inbound cross-cluster connection has been rejected
    When an outbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an outbound cross-cluster connection has been deleted
    When an inbound cross-cluster connection is deleted
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound connection finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an outbound connection has finished deleting
    When an inbound connection finishes deleting
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an inbound cross-cluster connection has been deleted
    When tags are added to a domain
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an inbound connection has finished deleting
    When a search domain is created
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    Given tags have been removed from a domain
    Given tags have been added to a domain
    When a search domain finishes creating
    Then no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"
