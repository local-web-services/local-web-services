@opensearch @generated
Feature: Opensearch - Action Sequences

  # Generated from FizzBee spec: opensearch.fizz
  # Safety invariants: ActiveConnectionsReferenceActiveDomains, TrafficSwapRequiresNewCluster, ConnectionStatusConsistency, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" finishes creating
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" configuration update is requested
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then a blue-green deployment completes
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "outbound connection" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "inbound connection" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then tags are added to an "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then tags are removed from an "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is created
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is created
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" is created
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When a blue-green deployment completes
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When a blue-green deployment completes
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" is created
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then a blue-green deployment completes
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" is created
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" finishes creating
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" configuration update is requested
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then a blue-green deployment completes
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "outbound connection" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "inbound connection" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are added to an "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are removed from an "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" is created
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is created
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes creating
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes deleting
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then a blue-green deployment completes
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "inbound connection" finishes deleting
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then tags are added to an "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then tags are removed from an "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" is created
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then a blue-green deployment completes
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is created
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then a blue-green deployment completes
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" finishes creating then an "opensearch" "domain" is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "domain" configuration update is requested then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" configuration update is requested
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then the new "opensearch" "cluster" for a blue-green deployment becomes ready then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then a blue-green deployment completes
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then a blue-green deployment completes then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is accepted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an outbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is deleted
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an inbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "inbound connection" finishes deleting then tags are added to an "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "inbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then tags are added to an "opensearch" "domain" then tags are removed from an "opensearch" "domain"
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When tags are added to an "opensearch" "domain"
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is created then tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain not in domain_status
    When an "opensearch" "domain" is created
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" is created then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" is deleted then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "domain" configuration update is requested then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" configuration update is requested
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then the new "opensearch" "cluster" for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then a blue-green deployment completes then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is rejected then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then an "opensearch" "inbound connection" finishes deleting then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "inbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then tags are added to an "opensearch" "domain" then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes creating then tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes creating
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" is created then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes creating then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes creating
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "domain" configuration update is requested then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" configuration update is requested
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then a blue-green deployment completes then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is accepted then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an outbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "outbound connection" finishes deleting then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "outbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an inbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" is deleted then tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" is deleted
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is created then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is created
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" finishes creating then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" finishes creating
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is deleted then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "domain" configuration update is requested then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then a blue-green deployment completes then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is rejected then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "outbound connection" finishes deleting then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "outbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is deleted then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then tags are added to an "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" finishes deleting then tags are removed from an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "opensearch" "domain" finishes deleting
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is created then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is created
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes creating then a blue-green deployment completes
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes creating
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is deleted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then a blue-green deployment completes then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is accepted then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is rejected then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is rejected
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an outbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an outbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is created
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "domain" configuration update is requested then tags are removed from an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When an "opensearch" "domain" configuration update is requested
    When tags are removed from an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is created then a blue-green deployment completes
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is created
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes creating then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes creating
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then a blue-green deployment completes then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When a blue-green deployment completes
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is accepted then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is accepted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is rejected then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is rejected
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an outbound cross-cluster connection is deleted then an "opensearch" "domain" is created
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are added to an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are removed from an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are removed from an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is created then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is created
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is deleted then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" configuration update is requested then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" configuration update is requested
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then a blue-green deployment completes then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is accepted then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is accepted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is rejected then an "opensearch" "domain" is created
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are added to an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are added to an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are removed from an "opensearch" "domain" then a blue-green deployment completes
    Given domain in domain_status
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are removed from an "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" is created then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" is deleted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" finishes deleting then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "domain" configuration update is requested then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then shards are rebalanced across nodes in an active "opensearch" "domain" then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is accepted then an "opensearch" "domain" is created
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an outbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When a blue-green deployment completes
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an inbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When a blue-green deployment completes
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then an "opensearch" "inbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When a blue-green deployment completes
    When an "opensearch" "inbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then tags are added to an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are added to an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a blue-green deployment completes then tags are removed from an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When a blue-green deployment completes
    When tags are removed from an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" is created then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" is deleted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes deleting then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" configuration update is requested then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then a blue-green deployment completes then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When a blue-green deployment completes
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" is created
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is accepted then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is rejected then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then tags are added to an "opensearch" "domain" then a blue-green deployment completes
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are rebalanced across nodes in an active "opensearch" "domain" then tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" is created then an inbound cross-cluster connection is rejected
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" finishes creating then an outbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" finishes creating
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" is deleted then an "opensearch" "outbound connection" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" finishes deleting then an inbound cross-cluster connection is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" configuration update is requested then an "opensearch" "inbound connection" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are added to an "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then tags are removed from an "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then a blue-green deployment completes then an "opensearch" "domain" is created
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When a blue-green deployment completes
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is accepted then an "opensearch" "domain" is deleted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes deleting
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an outbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "outbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "outbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "inbound connection" finishes deleting then a blue-green deployment completes
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "inbound connection" finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are added to an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are added to an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is created between two "opensearch" "domain"s then tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given conn not in outbound_status
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" is created then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is created
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" finishes creating then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" is deleted then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" finishes deleting then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "domain" configuration update is requested then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "domain" configuration update is requested
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then the new "opensearch" "cluster" for a blue-green deployment becomes ready then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then a blue-green deployment completes then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "outbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "outbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is deleted then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then an "opensearch" "inbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When an "opensearch" "inbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is accepted then tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is accepted
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" is created then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is created
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes creating then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes creating
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" is deleted then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" finishes deleting then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" finishes deleting
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "domain" configuration update is requested then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "domain" configuration update is requested
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then a blue-green deployment completes then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "outbound connection" finishes deleting then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "outbound connection" finishes deleting
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is rejected then tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is rejected
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" is created then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating then an "opensearch" "inbound connection" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted then tags are added to an "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting then tags are removed from an "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is created
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes creating
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" is deleted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then a blue-green deployment completes then an "opensearch" "domain" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When a blue-green deployment completes
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active "opensearch" "domain" then an "opensearch" "domain" configuration update is requested
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then a blue-green deployment completes
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an outbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given conn in outbound_status
    When an outbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is created then an "opensearch" "inbound connection" finishes deleting
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is created
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes creating then tags are added to an "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" is deleted then tags are removed from an "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is created
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes creating
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" finishes deleting
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then a blue-green deployment completes then an "opensearch" "domain" configuration update is requested
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When a blue-green deployment completes
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is accepted then a blue-green deployment completes
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is accepted
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is rejected then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an outbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "outbound connection" finishes deleting then tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given conn in outbound_status
    When an "opensearch" "outbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" is created then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is created
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes creating then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes creating
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" is deleted then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" finishes deleting then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then a blue-green deployment completes then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When a blue-green deployment completes
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then shards are rebalanced across nodes in an active "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is created between two "opensearch" "domain"s then a blue-green deployment completes
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an inbound cross-cluster connection is deleted then tags are removed from an "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting
    Given conn in inbound_status
    When an inbound cross-cluster connection is deleted
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is created then tags are removed from an "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is created
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes creating then an "opensearch" "domain" is created
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes creating
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" finishes deleting then an "opensearch" "domain" is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" configuration update is requested then an "opensearch" "domain" finishes deleting
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready then an "opensearch" "domain" configuration update is requested
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then a blue-green deployment completes then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When a blue-green deployment completes
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then shards are rebalanced across nodes in an active "opensearch" "domain" then a blue-green deployment completes
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is created between two "opensearch" "domain"s then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is rejected then an inbound cross-cluster connection is accepted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is rejected
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is rejected
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an "opensearch" "outbound connection" finishes deleting then an outbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "outbound connection" finishes deleting
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then an inbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is deleted
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "opensearch" "inbound connection" finishes deleting then tags are removed from an "opensearch" "domain" then tags are added to an "opensearch" "domain"
    Given conn in inbound_status
    When an "opensearch" "inbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" is created then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes creating then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" is deleted then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes deleting then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then a blue-green deployment completes
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then a blue-green deployment completes then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When a blue-green deployment completes
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is accepted then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is rejected then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an outbound cross-cluster connection is deleted then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an inbound cross-cluster connection is deleted then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting then tags are removed from an "opensearch" "domain"
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    When tags are removed from an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "opensearch" "domain" then tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is created
    Given domain in domain_status
    When tags are added to an "opensearch" "domain"
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is created then an "opensearch" "domain" is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is created
    When an "opensearch" "domain" is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes creating then an "opensearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    When an "opensearch" "domain" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" is deleted then an "opensearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" is deleted
    When an "opensearch" "domain" configuration update is requested
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" finishes deleting then the new "opensearch" "cluster" for a blue-green deployment becomes ready
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" finishes deleting
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "domain" configuration update is requested then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "domain" configuration update is requested
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then the new "opensearch" "cluster" for a blue-green deployment becomes ready then a blue-green deployment completes
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When the new "opensearch" "cluster" for a blue-green deployment becomes ready
    When a blue-green deployment completes
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment then shards are rebalanced across nodes in an active "opensearch" "domain"
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then a blue-green deployment completes then an outbound cross-cluster connection is created between two "opensearch" "domain"s
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When a blue-green deployment completes
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then shards are rebalanced across nodes in an active "opensearch" "domain" then an inbound cross-cluster connection is accepted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When shards are rebalanced across nodes in an active "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is created between two "opensearch" "domain"s then an inbound cross-cluster connection is rejected
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is created between two "opensearch" "domain"s
    When an inbound cross-cluster connection is rejected
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is accepted then an outbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is accepted
    When an outbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is rejected then an "opensearch" "outbound connection" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is rejected
    When an "opensearch" "outbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an outbound cross-cluster connection is deleted then an inbound cross-cluster connection is deleted
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an outbound cross-cluster connection is deleted
    When an inbound cross-cluster connection is deleted
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "outbound connection" finishes deleting then an "opensearch" "inbound connection" finishes deleting
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "outbound connection" finishes deleting
    When an "opensearch" "inbound connection" finishes deleting
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an inbound cross-cluster connection is deleted then tags are added to an "opensearch" "domain"
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an inbound cross-cluster connection is deleted
    When tags are added to an "opensearch" "domain"
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then an "opensearch" "inbound connection" finishes deleting then an "opensearch" "domain" is created
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When an "opensearch" "inbound connection" finishes deleting
    When an "opensearch" "domain" is created
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "opensearch" "domain" then tags are added to an "opensearch" "domain" then an "opensearch" "domain" finishes creating
    Given domain in domain_status
    When tags are removed from an "opensearch" "domain"
    When tags are added to an "opensearch" "domain"
    When an "opensearch" "domain" finishes creating
    And no active connection references a deleted domain
    And traffic can only be swapped after the new "opensearch" "cluster" was ready
    And an "opensearch" "outbound connection" that was "ACTIVE" cannot have a "REJECTED" inbound connection
    And a pending config change only exists on a "opensearch" "domain" that is "PROCESSING"
