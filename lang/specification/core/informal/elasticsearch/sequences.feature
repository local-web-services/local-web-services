@elasticsearch @generated
Feature: Elasticsearch - Action Sequences

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes creating
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" is deleted
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes deleting
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" configuration update is requested
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a "elasticsearch" "document" is indexed in an active index
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then tags are added to an "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then tags are removed from an "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a node failure occurs in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is deleted
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes deleting
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" configuration update is requested
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then tags are added to an "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When tags are added to an "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then tags are removed from an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When tags are removed from an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then shards are reallocated across nodes in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a replica sync lag event occurs on an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is created then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain not in domain_status
    When an "elasticsearch" "domain" is created
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes processing its configuration update then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a "elasticsearch" "document" is indexed in an active index then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a "elasticsearch" "document" is indexed in an active index
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then tags are added to an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When tags are added to an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then tags are removed from an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When tags are removed from an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then shards are reallocated across nodes in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes creating then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes creating
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" is created then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" configuration update is requested then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" configuration update is requested
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a "elasticsearch" "document" is indexed in an active index then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a "elasticsearch" "document" is indexed in an active index
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then tags are added to an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When tags are added to an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then tags are removed from an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When tags are removed from an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" is deleted then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" is deleted
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is deleted then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is deleted
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes processing its configuration update then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a "elasticsearch" "document" is indexed in an active index then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a "elasticsearch" "document" is indexed in an active index
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then tags are added to an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When tags are added to an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes deleting then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes deleting
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is created then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes creating then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes creating
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is deleted then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes deleting then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes deleting
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes processing its configuration update then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a "elasticsearch" "document" is indexed in an active index then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a "elasticsearch" "document" is indexed in an active index
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" configuration update is requested then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "domain" configuration update is requested
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is created then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is created
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is deleted then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is deleted
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes deleting then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes deleting
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" configuration update is requested then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" configuration update is requested
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a "elasticsearch" "document" is indexed in an active index then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a "elasticsearch" "document" is indexed in an active index
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" is created then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" is created
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes creating then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes creating
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" is deleted then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" is deleted
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes deleting then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes deleting
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" configuration update is requested then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" configuration update is requested
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a "elasticsearch" "document" is indexed in an active index then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a "elasticsearch" "document" is indexed in an active index
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is created then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are added to an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When tags are added to an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is created then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: tags are removed from an "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When tags are removed from an "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" then a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created then an "elasticsearch" "domain" is deleted
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    When an "elasticsearch" "domain" is deleted
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating then an "elasticsearch" "domain" finishes deleting
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    When an "elasticsearch" "domain" finishes deleting
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is deleted then an "elasticsearch" "domain" configuration update is requested
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is deleted
    When an "elasticsearch" "domain" configuration update is requested
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes deleting then an "elasticsearch" "domain" finishes processing its configuration update
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes deleting
    When an "elasticsearch" "domain" finishes processing its configuration update
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" configuration update is requested then an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" configuration update is requested
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes processing its configuration update then a "elasticsearch" "document" is indexed in an active index
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes processing its configuration update
    When a "elasticsearch" "document" is indexed in an active index
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is created in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then a "elasticsearch" "document" is indexed in an active index then tags are added to an "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When a "elasticsearch" "document" is indexed in an active index
    When tags are added to an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then tags are added to an "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are added to an "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then tags are removed from an "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When tags are removed from an "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then shards are reallocated across nodes in an active "elasticsearch" "domain" then an "elasticsearch" "domain" is created
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When shards are reallocated across nodes in an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" is created
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active "elasticsearch" "domain" then a replica sync lag event occurs on an active "elasticsearch" "domain" then an "elasticsearch" "domain" finishes creating
    Given domain in domain_status
    When a node failure occurs in an active "elasticsearch" "domain"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    When an "elasticsearch" "domain" finishes creating
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"
