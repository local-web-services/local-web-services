@opensearch @generated
Feature: Opensearch - Action Sequences

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes creating
    Given domain not in domain_status
    When a search domain is created
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain is deleted
    Given domain not in domain_status
    When a search domain is created
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a domain configuration update is requested
    Given domain not in domain_status
    When a search domain is created
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then the new cluster for a blue-green deployment becomes ready
    Given domain not in domain_status
    When a search domain is created
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then traffic is swapped to the new cluster during a blue-green deployment
    Given domain not in domain_status
    When a search domain is created
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a blue-green deployment completes
    Given domain not in domain_status
    When a search domain is created
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then shards are rebalanced across nodes in an active domain
    Given domain not in domain_status
    When a search domain is created
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is created between two domains
    Given domain not in domain_status
    When a search domain is created
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    When a search domain is created
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound connection finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound connection finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are added to a domain
    Given domain not in domain_status
    When a search domain is created
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are removed from a domain
    Given domain not in domain_status
    When a search domain is created
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is created
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested
    Given domain in domain_status
    When a search domain finishes creating
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain finishes creating
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain finishes creating
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a blue-green deployment completes
    Given domain in domain_status
    When a search domain finishes creating
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain finishes creating
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are added to a domain
    Given domain in domain_status
    When a search domain finishes creating
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain
    Given domain in domain_status
    When a search domain finishes creating
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain is created
    Given domain in domain_status
    When a search domain is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes creating
    Given domain in domain_status
    When a search domain is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    When a search domain is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain is deleted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a blue-green deployment completes
    Given domain in domain_status
    When a search domain is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain is deleted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are added to a domain
    Given domain in domain_status
    When a search domain is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are removed from a domain
    Given domain in domain_status
    When a search domain is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is created
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    When a search domain finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a blue-green deployment completes
    Given domain in domain_status
    When a search domain finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain finishes deleting
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain
    Given domain in domain_status
    When a search domain finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain
    Given domain in domain_status
    When a search domain finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is created
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a domain configuration update is requested
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a domain configuration update is requested
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    When a domain configuration update is requested
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a domain configuration update is requested
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound connection finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound connection finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain
    Given domain in domain_status
    When a domain configuration update is requested
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain
    Given domain in domain_status
    When a domain configuration update is requested
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is created
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes creating
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are added to a domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are removed from a domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is created
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound connection finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is created
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes creating
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a domain configuration update is requested
    Given domain in domain_status
    When a blue-green deployment completes
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a blue-green deployment completes
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a blue-green deployment completes
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound connection finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound connection finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are added to a domain
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are removed from a domain
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is created
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes creating
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a domain configuration update is requested
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a blue-green deployment completes
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are added to a domain
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are removed from a domain
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is created
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes creating
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a domain configuration update is requested
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a blue-green deployment completes
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are added to a domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are removed from a domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is created
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes creating
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to a domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from a domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is created
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes creating
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes deleting
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a domain configuration update is requested
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound connection finishes deleting
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are added to a domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are removed from a domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is created
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes creating
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are added to a domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are removed from a domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is created
    Given domain in domain_status
    When tags are added to a domain
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    When tags are added to a domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    When tags are added to a domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    When tags are added to a domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are added to a domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When tags are added to a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a blue-green deployment completes
    Given domain in domain_status
    When tags are added to a domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When tags are added to a domain
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When tags are added to a domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to a domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound connection finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound connection finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then tags are removed from a domain
    Given domain in domain_status
    When tags are added to a domain
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is created
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    When tags are removed from a domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are removed from a domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When tags are removed from a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a blue-green deployment completes
    Given domain in domain_status
    When tags are removed from a domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When tags are removed from a domain
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound connection finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound connection finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then tags are added to a domain
    Given domain in domain_status
    When tags are removed from a domain
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes creating then a search domain is deleted
    Given domain not in domain_status
    When a search domain is created
    When a search domain finishes creating
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain is deleted then a search domain finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When a search domain is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a search domain finishes deleting then a domain configuration update is requested
    Given domain not in domain_status
    When a search domain is created
    When a search domain finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain not in domain_status
    When a search domain is created
    When a domain configuration update is requested
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain not in domain_status
    When a search domain is created
    When the new cluster for a blue-green deployment becomes ready
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain not in domain_status
    When a search domain is created
    When traffic is swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain not in domain_status
    When a search domain is created
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain not in domain_status
    When a search domain is created
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    When a search domain is created
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When an outbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    When a search domain is created
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain not in domain_status
    When a search domain is created
    When an inbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then an inbound connection finishes deleting then tags are added to a domain
    Given domain not in domain_status
    When a search domain is created
    When an inbound connection finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are added to a domain then tags are removed from a domain
    Given domain not in domain_status
    When a search domain is created
    When tags are added to a domain
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is created then tags are removed from a domain then a search domain finishes creating
    Given domain not in domain_status
    When a search domain is created
    When tags are removed from a domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is created then a search domain finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain is created
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain finishes creating
    When a search domain finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain finishes creating
    When a domain configuration update is requested
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When a search domain finishes creating
    When the new cluster for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain finishes creating
    When traffic is swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain finishes creating
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain finishes creating
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is rejected
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an outbound connection finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes creating
    When an outbound connection finishes deleting
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound cross-cluster connection is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then an inbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    When a search domain finishes creating
    When an inbound connection finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are added to a domain then a search domain is created
    Given domain in domain_status
    When a search domain finishes creating
    When tags are added to a domain
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    When a search domain finishes creating
    When tags are removed from a domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain is created then a domain configuration update is requested
    Given domain in domain_status
    When a search domain is deleted
    When a search domain is created
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes creating then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain is deleted
    When a search domain finishes creating
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain is deleted
    When a search domain finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    When a search domain is deleted
    When a domain configuration update is requested
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain is deleted
    When the new cluster for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain is deleted
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain is deleted
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain is deleted
    When an outbound cross-cluster connection is created between two domains
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is accepted then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is accepted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When an outbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an outbound connection finishes deleting then tags are added to a domain
    Given domain in domain_status
    When a search domain is deleted
    When an outbound connection finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound cross-cluster connection is deleted then tags are removed from a domain
    Given domain in domain_status
    When a search domain is deleted
    When an inbound cross-cluster connection is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then an inbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    When a search domain is deleted
    When an inbound connection finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    When a search domain is deleted
    When tags are added to a domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain is deleted then tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    When a search domain is deleted
    When tags are removed from a domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is created then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain is created
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain finishes creating
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted then a blue-green deployment completes
    Given domain in domain_status
    When a search domain finishes deleting
    When a search domain is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a search domain finishes deleting
    When a domain configuration update is requested
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a search domain finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a search domain finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a search domain finishes deleting
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound cross-cluster connection is created between two domains
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is rejected then an inbound connection finishes deleting
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is rejected
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound cross-cluster connection is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an outbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    When a search domain finishes deleting
    When an outbound connection finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound cross-cluster connection is deleted then a search domain is created
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound cross-cluster connection is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then an inbound connection finishes deleting then a search domain finishes creating
    Given domain in domain_status
    When a search domain finishes deleting
    When an inbound connection finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    When a search domain finishes deleting
    When tags are added to a domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    When a search domain finishes deleting
    When tags are removed from a domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is created then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain is created
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating then a blue-green deployment completes
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain finishes creating
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain is deleted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a domain configuration update is requested
    When a search domain finishes deleting
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a domain configuration update is requested
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a domain configuration update is requested
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When shards are rebalanced across nodes in an active domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is accepted then an inbound connection finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is accepted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is rejected then tags are added to a domain
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is rejected
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound cross-cluster connection is deleted then tags are removed from a domain
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound cross-cluster connection is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an outbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    When a domain configuration update is requested
    When an outbound connection finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound cross-cluster connection is deleted then a search domain finishes creating
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound cross-cluster connection is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then an inbound connection finishes deleting then a search domain is deleted
    Given domain in domain_status
    When a domain configuration update is requested
    When an inbound connection finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    When a domain configuration update is requested
    When tags are added to a domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a domain configuration update is requested
    When tags are removed from a domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is created then a blue-green deployment completes
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is created
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes creating then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes creating
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain is deleted then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a domain configuration update is requested
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes then an outbound connection finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When a blue-green deployment completes
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two domains
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted then tags are added to a domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected then tags are removed from a domain
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is rejected
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted then a search domain is created
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting then a search domain finishes creating
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an outbound connection finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted then a search domain is deleted
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting then a search domain finishes deleting
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When an inbound connection finishes deleting
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When tags are added to a domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: the new cluster for a blue-green deployment becomes ready then tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When the new cluster for a blue-green deployment becomes ready
    When tags are removed from a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is created then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is created
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes creating
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a domain configuration update is requested
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready then an outbound connection finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When the new cluster for a blue-green deployment becomes ready
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is created between two domains then tags are added to a domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is created between two domains
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is accepted then tags are removed from a domain
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is rejected then a search domain is created
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound cross-cluster connection is deleted then a search domain finishes creating
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an outbound connection finishes deleting then a search domain is deleted
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an outbound connection finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound cross-cluster connection is deleted then a search domain finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound cross-cluster connection is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound connection finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are added to a domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain then a blue-green deployment completes
    Given domain in domain_status
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are removed from a domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is created then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain is created
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain finishes creating
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a search domain finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When a search domain finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then a domain configuration update is requested then an outbound connection finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When a domain configuration update is requested
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When the new cluster for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment then an inbound connection finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When traffic is swapped to the new cluster during a blue-green deployment
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active domain then tags are added to a domain
    Given domain in domain_status
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active domain
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two domains then tags are removed from a domain
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two domains
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted then a search domain is created
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected then a search domain finishes creating
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted then a search domain is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an outbound connection finishes deleting then a search domain finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound connection finishes deleting
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted then a domain configuration update is requested
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are added to a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: a blue-green deployment completes then tags are removed from a domain then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are removed from a domain
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is created then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain is created
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes creating
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a search domain finishes deleting then an outbound connection finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes deleting
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a domain configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a domain configuration update is requested
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready then an inbound connection finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When the new cluster for a blue-green deployment becomes ready
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment then tags are added to a domain
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then a blue-green deployment completes then tags are removed from a domain
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When a blue-green deployment completes
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains then a search domain is created
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted then a search domain finishes creating
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is rejected then a search domain is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is rejected
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is deleted then a search domain finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an outbound connection finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an outbound connection finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When an inbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are added to a domain then a blue-green deployment completes
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When tags are added to a domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: shards are rebalanced across nodes in an active domain then tags are removed from a domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When shards are rebalanced across nodes in an active domain
    When tags are removed from a domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is created then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain is created
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes creating then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain finishes creating
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain is deleted then an outbound connection finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a search domain finishes deleting then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a search domain finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a domain configuration update is requested then an inbound connection finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a domain configuration update is requested
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready then tags are added to a domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When the new cluster for a blue-green deployment becomes ready
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment then tags are removed from a domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When traffic is swapped to the new cluster during a blue-green deployment
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then a blue-green deployment completes then a search domain is created
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When a blue-green deployment completes
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain then a search domain finishes creating
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted then a search domain is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is accepted
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected then a search domain finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is rejected
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound cross-cluster connection is deleted then a domain configuration update is requested
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an outbound cross-cluster connection is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an outbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then an inbound connection finishes deleting then a blue-green deployment completes
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When an inbound connection finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are added to a domain then shards are rebalanced across nodes in an active domain
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When tags are added to a domain
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is created between two domains then tags are removed from a domain then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two domains
    When tags are removed from a domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is created then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain is created
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes creating then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain finishes creating
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain is deleted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a search domain finishes deleting then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a search domain finishes deleting
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a domain configuration update is requested then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a domain configuration update is requested
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When the new cluster for a blue-green deployment becomes ready
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active domain
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two domains
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to a domain then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are added to a domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from a domain then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are removed from a domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is created then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain is created
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes creating then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain finishes creating
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain is deleted then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a search domain finishes deleting then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a search domain finishes deleting
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a domain configuration update is requested then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a domain configuration update is requested
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new cluster for a blue-green deployment becomes ready then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active domain
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two domains
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound connection finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound connection finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to a domain then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are added to a domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from a domain then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are removed from a domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is created then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain is created
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes creating then an inbound connection finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain finishes creating
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain is deleted then tags are added to a domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a search domain finishes deleting then tags are removed from a domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a search domain finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a domain configuration update is requested then a search domain is created
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a domain configuration update is requested
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready then a search domain finishes creating
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment then a search domain is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes then a search domain finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a blue-green deployment completes
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain then a domain configuration update is requested
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active domain
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound connection finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to a domain then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are added to a domain
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from a domain then an outbound connection finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are removed from a domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is created then an inbound connection finishes deleting
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain is created
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes creating then tags are added to a domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain finishes creating
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain is deleted then tags are removed from a domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain is deleted
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a search domain finishes deleting then a search domain is created
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a search domain finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a domain configuration update is requested then a search domain finishes creating
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a domain configuration update is requested
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready then a search domain is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then a search domain finishes deleting
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then a blue-green deployment completes then a domain configuration update is requested
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When a blue-green deployment completes
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then shards are rebalanced across nodes in an active domain then the new cluster for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is created between two domains then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an outbound cross-cluster connection is created between two domains
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active domain
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then an inbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are added to a domain then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When tags are added to a domain
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an outbound connection finishes deleting then tags are removed from a domain then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound connection finishes deleting
    When tags are removed from a domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is created then tags are added to a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain is created
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes creating then tags are removed from a domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain finishes creating
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain is deleted then a search domain is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain is deleted
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a search domain finishes deleting then a search domain finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a search domain finishes deleting
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a domain configuration update is requested then a search domain is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a domain configuration update is requested
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new cluster for a blue-green deployment becomes ready then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When the new cluster for a blue-green deployment becomes ready
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new cluster during a blue-green deployment then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new cluster during a blue-green deployment
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active domain then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active domain
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two domains then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two domains
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound connection finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to a domain then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are added to a domain
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from a domain then an inbound connection finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are removed from a domain
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is created then tags are removed from a domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain is created
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes creating then a search domain is created
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain finishes creating
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain is deleted then a search domain finishes creating
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain is deleted
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a search domain finishes deleting then a search domain is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a search domain finishes deleting
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a domain configuration update is requested then a search domain finishes deleting
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a domain configuration update is requested
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then the new cluster for a blue-green deployment becomes ready then a domain configuration update is requested
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then traffic is swapped to the new cluster during a blue-green deployment then the new cluster for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When traffic is swapped to the new cluster during a blue-green deployment
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then a blue-green deployment completes then traffic is swapped to the new cluster during a blue-green deployment
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When a blue-green deployment completes
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then shards are rebalanced across nodes in an active domain then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When shards are rebalanced across nodes in an active domain
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is created between two domains then shards are rebalanced across nodes in an active domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is created between two domains
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two domains
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an outbound connection finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an outbound connection finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then an inbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are added to a domain then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When tags are added to a domain
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: an inbound connection finishes deleting then tags are removed from a domain then tags are added to a domain
    Given conn in inbound_status
    When an inbound connection finishes deleting
    When tags are removed from a domain
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is created then a search domain finishes creating
    Given domain in domain_status
    When tags are added to a domain
    When a search domain is created
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    When tags are added to a domain
    When a search domain finishes creating
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When a search domain is deleted
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    When tags are added to a domain
    When a search domain finishes deleting
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are added to a domain
    When a domain configuration update is requested
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then the new cluster for a blue-green deployment becomes ready then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When tags are added to a domain
    When the new cluster for a blue-green deployment becomes ready
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then traffic is swapped to the new cluster during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    When tags are added to a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then a blue-green deployment completes then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When tags are added to a domain
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then shards are rebalanced across nodes in an active domain then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When tags are added to a domain
    When shards are rebalanced across nodes in an active domain
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are added to a domain
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound cross-cluster connection is deleted then an outbound connection finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When an outbound cross-cluster connection is deleted
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an outbound connection finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to a domain
    When an outbound connection finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound cross-cluster connection is deleted then an inbound connection finishes deleting
    Given domain in domain_status
    When tags are added to a domain
    When an inbound cross-cluster connection is deleted
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then an inbound connection finishes deleting then tags are removed from a domain
    Given domain in domain_status
    When tags are added to a domain
    When an inbound connection finishes deleting
    When tags are removed from a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are added to a domain then tags are removed from a domain then a search domain is created
    Given domain in domain_status
    When tags are added to a domain
    When tags are removed from a domain
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is created then a search domain is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain is created
    When a search domain is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain finishes creating
    When a search domain finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain is deleted
    When a domain configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting then the new cluster for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are removed from a domain
    When a search domain finishes deleting
    When the new cluster for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested then traffic is swapped to the new cluster during a blue-green deployment
    Given domain in domain_status
    When tags are removed from a domain
    When a domain configuration update is requested
    When traffic is swapped to the new cluster during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then the new cluster for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When tags are removed from a domain
    When the new cluster for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then traffic is swapped to the new cluster during a blue-green deployment then shards are rebalanced across nodes in an active domain
    Given domain in domain_status
    When tags are removed from a domain
    When traffic is swapped to the new cluster during a blue-green deployment
    When shards are rebalanced across nodes in an active domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then a blue-green deployment completes then an outbound cross-cluster connection is created between two domains
    Given domain in domain_status
    When tags are removed from a domain
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two domains
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then shards are rebalanced across nodes in an active domain then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are removed from a domain
    When shards are rebalanced across nodes in an active domain
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is created between two domains then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound cross-cluster connection is created between two domains
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is rejected then an outbound connection finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is rejected
    When an outbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an outbound connection finishes deleting then an inbound connection finishes deleting
    Given domain in domain_status
    When tags are removed from a domain
    When an outbound connection finishes deleting
    When an inbound connection finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound cross-cluster connection is deleted then tags are added to a domain
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound cross-cluster connection is deleted
    When tags are added to a domain
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then an inbound connection finishes deleting then a search domain is created
    Given domain in domain_status
    When tags are removed from a domain
    When an inbound connection finishes deleting
    When a search domain is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"

  @exhaustive @sequence
  Scenario: tags are removed from a domain then tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    When tags are removed from a domain
    When tags are added to a domain
    When a search domain finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new cluster is ready
    And an outbound connection that is "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a domain that is "PROCESSING"
