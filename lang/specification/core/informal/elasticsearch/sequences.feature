@elasticsearch @generated
Feature: Elasticsearch - Action Sequences

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a search domain is created then a search domain finishes creating
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a search domain is deleted
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a search domain finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a domain configuration update is requested
    Given domain not in domain_status
    Given a search domain has been created
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a domain finishes processing its configuration update
    Given domain not in domain_status
    Given a search domain has been created
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then an index is created in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a document is indexed in an active index
    Given domain not in domain_status
    Given a search domain has been created
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then an index is deleted from an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then tags are added to a domain
    Given domain not in domain_status
    Given a search domain has been created
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then tags are removed from a domain
    Given domain not in domain_status
    Given a search domain has been created
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then shards are reallocated across nodes in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a replica sync lag event occurs on an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a node failure occurs in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain is created
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished creating
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has finished creating
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has finished creating
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished creating
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished creating
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain is created
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has been deleted
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has been deleted
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then tags are added to a domain
    Given domain in domain_status
    Given a search domain has been deleted
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has been deleted
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain is created
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has finished deleting
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has finished deleting
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain is created
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then an index is created in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a document is indexed in an active index
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then an index is deleted from an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a node failure occurs in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain is created
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain finishes creating
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain is deleted
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain finishes deleting
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a domain configuration update is requested
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then an index is created in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a document is indexed in an active index
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then an index is deleted from an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then tags are added to a domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then tags are removed from a domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a node failure occurs in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain is created
    Given domain in domain_status
    Given an index has been created in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given an index has been created in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain is deleted
    Given domain in domain_status
    Given an index has been created in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given an index has been created in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given an index has been created in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given an index has been created in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given an index has been created in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then tags are added to a domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain is created
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain finishes creating
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain is deleted
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain finishes deleting
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a domain configuration update is requested
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then an index is created in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then an index is deleted from an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then tags are added to a domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then tags are removed from a domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a node failure occurs in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain is created
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain finishes creating
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain is deleted
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then an index is created in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then tags are added to a domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then tags are removed from a domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain is created
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been added to a domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given tags have been added to a domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then an index is created in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a document is indexed in an active index
    Given domain in domain_status
    Given tags have been added to a domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then an index is deleted from an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then tags are removed from a domain
    Given domain in domain_status
    Given tags have been added to a domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain is created
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been removed from a domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given tags have been removed from a domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then an index is created in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a document is indexed in an active index
    Given domain in domain_status
    Given tags have been removed from a domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then an index is deleted from an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then tags are added to a domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain is created
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain is deleted
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then an index is created in an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then tags are added to a domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain is created
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain is deleted
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then an index is created in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then tags are added to a domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then tags are removed from a domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain is created
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain is deleted
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then an index is created in an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then tags are added to a domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a search domain finishes creating then a search domain is deleted
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has finished creating
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a search domain is deleted then a search domain finishes deleting
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a search domain finishes deleting then a domain configuration update is requested
    Given domain not in domain_status
    Given a search domain has been created
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a domain configuration update is requested then a domain finishes processing its configuration update
    Given domain not in domain_status
    Given a search domain has been created
    Given a domain configuration update has been requested
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a domain finishes processing its configuration update then an index is created in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given a domain has finished processing its configuration update
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then an index is created in an active domain then a document is indexed in an active index
    Given domain not in domain_status
    Given a search domain has been created
    Given an index has been created in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a document is indexed in an active index then an index is deleted from an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given a document has been indexed in an active index
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then an index is deleted from an active domain then tags are added to a domain
    Given domain not in domain_status
    Given a search domain has been created
    Given an index has been deleted from an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then tags are added to a domain then tags are removed from a domain
    Given domain not in domain_status
    Given a search domain has been created
    Given tags have been added to a domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then tags are removed from a domain then shards are reallocated across nodes in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given tags have been removed from a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then shards are reallocated across nodes in an active domain then a replica sync lag event occurs on an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given shards have been reallocated across nodes in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a replica sync lag event occurs on an active domain then a node failure occurs in an active domain
    Given domain not in domain_status
    Given a search domain has been created
    Given a replica sync lag event has occurred on an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is created then a node failure occurs in an active domain then a search domain finishes creating
    Given domain not in domain_status
    Given a search domain has been created
    Given a node failure has occurred in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain is created then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has been created
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a search domain finishes deleting then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has finished creating
    Given a search domain has finished deleting
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a domain configuration update is requested then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given a domain configuration update has been requested
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a domain finishes processing its configuration update then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has finished creating
    Given a domain has finished processing its configuration update
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then an index is created in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given an index has been created in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a document is indexed in an active index then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given a document has been indexed in an active index
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then an index is deleted from an active domain then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given an index has been deleted from an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then tags are added to a domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given tags have been added to a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then tags are removed from a domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given tags have been removed from a domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then shards are reallocated across nodes in an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has finished creating
    Given shards have been reallocated across nodes in an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a replica sync lag event occurs on an active domain then a search domain is created
    Given domain in domain_status
    Given a search domain has finished creating
    Given a replica sync lag event has occurred on an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes creating then a node failure occurs in an active domain then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished creating
    Given a node failure has occurred in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain is created then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has been created
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain finishes creating then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has finished creating
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a search domain finishes deleting then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given a search domain has finished deleting
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a domain configuration update is requested then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has been deleted
    Given a domain configuration update has been requested
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a domain finishes processing its configuration update then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given a domain has finished processing its configuration update
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then an index is created in an active domain then tags are added to a domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given an index has been created in an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a document is indexed in an active index then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given a document has been indexed in an active index
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then an index is deleted from an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given an index has been deleted from an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then tags are added to a domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given tags have been added to a domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then tags are removed from a domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has been deleted
    Given tags have been removed from a domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then shards are reallocated across nodes in an active domain then a search domain is created
    Given domain in domain_status
    Given a search domain has been deleted
    Given shards have been reallocated across nodes in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a replica sync lag event occurs on an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has been deleted
    Given a replica sync lag event has occurred on an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain is deleted then a node failure occurs in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given a search domain has been deleted
    Given a node failure has occurred in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain is created then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has been created
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain finishes creating then an index is created in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has finished creating
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a search domain is deleted then a document is indexed in an active index
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a search domain has been deleted
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a domain configuration update is requested then an index is deleted from an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a domain configuration update has been requested
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a domain finishes processing its configuration update then tags are added to a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a domain has finished processing its configuration update
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then an index is created in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an index has been created in an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a document is indexed in an active index then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a document has been indexed in an active index
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then an index is deleted from an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given an index has been deleted from an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then tags are added to a domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a search domain has finished deleting
    Given tags have been added to a domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then tags are removed from a domain then a search domain is created
    Given domain in domain_status
    Given a search domain has finished deleting
    Given tags have been removed from a domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then shards are reallocated across nodes in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a search domain has finished deleting
    Given shards have been reallocated across nodes in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a replica sync lag event occurs on an active domain then a search domain is deleted
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a replica sync lag event has occurred on an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a search domain finishes deleting then a node failure occurs in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given a search domain has finished deleting
    Given a node failure has occurred in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain is created then an index is created in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has been created
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain finishes creating then a document is indexed in an active index
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has finished creating
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain is deleted then an index is deleted from an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has been deleted
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a search domain finishes deleting then tags are added to a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a search domain has finished deleting
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a domain finishes processing its configuration update then tags are removed from a domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a domain has finished processing its configuration update
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then an index is created in an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an index has been created in an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a document is indexed in an active index then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a document has been indexed in an active index
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then an index is deleted from an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given an index has been deleted from an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then tags are added to a domain then a search domain is created
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given tags have been added to a domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then tags are removed from a domain then a search domain finishes creating
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given tags have been removed from a domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then shards are reallocated across nodes in an active domain then a search domain is deleted
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given shards have been reallocated across nodes in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a replica sync lag event occurs on an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a replica sync lag event has occurred on an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain configuration update is requested then a node failure occurs in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a domain configuration update has been requested
    Given a node failure has occurred in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain is created then a document is indexed in an active index
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a search domain has been created
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain finishes creating then an index is deleted from an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a search domain has finished creating
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain is deleted then tags are added to a domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a search domain has been deleted
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a search domain finishes deleting then tags are removed from a domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a search domain has finished deleting
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a domain configuration update is requested then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a domain configuration update has been requested
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then an index is created in an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given an index has been created in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a document is indexed in an active index then a node failure occurs in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a document has been indexed in an active index
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then an index is deleted from an active domain then a search domain is created
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given an index has been deleted from an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then tags are added to a domain then a search domain finishes creating
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given tags have been added to a domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then tags are removed from a domain then a search domain is deleted
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given tags have been removed from a domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then shards are reallocated across nodes in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given shards have been reallocated across nodes in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a replica sync lag event occurs on an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a replica sync lag event has occurred on an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a domain finishes processing its configuration update then a node failure occurs in an active domain then an index is created in an active domain
    Given domain in domain_status
    Given a domain has finished processing its configuration update
    Given a node failure has occurred in an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain is created then an index is deleted from an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a search domain has been created
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain finishes creating then tags are added to a domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a search domain has finished creating
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain is deleted then tags are removed from a domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a search domain has been deleted
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a search domain finishes deleting then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a search domain has finished deleting
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a domain configuration update is requested then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a domain configuration update has been requested
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a domain finishes processing its configuration update then a node failure occurs in an active domain
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a domain has finished processing its configuration update
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a document is indexed in an active index then a search domain is created
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a document has been indexed in an active index
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then an index is deleted from an active domain then a search domain finishes creating
    Given domain in domain_status
    Given an index has been created in an active domain
    Given an index has been deleted from an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then tags are added to a domain then a search domain is deleted
    Given domain in domain_status
    Given an index has been created in an active domain
    Given tags have been added to a domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then tags are removed from a domain then a search domain finishes deleting
    Given domain in domain_status
    Given an index has been created in an active domain
    Given tags have been removed from a domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then shards are reallocated across nodes in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given an index has been created in an active domain
    Given shards have been reallocated across nodes in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a replica sync lag event occurs on an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a replica sync lag event has occurred on an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is created in an active domain then a node failure occurs in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given an index has been created in an active domain
    Given a node failure has occurred in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain is created then tags are added to a domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a search domain has been created
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain finishes creating then tags are removed from a domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a search domain has finished creating
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain is deleted then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a search domain has been deleted
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a search domain finishes deleting then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a search domain has finished deleting
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a domain configuration update is requested then a node failure occurs in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a domain configuration update has been requested
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a domain finishes processing its configuration update then a search domain is created
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a domain has finished processing its configuration update
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then an index is created in an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given an index has been created in an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then an index is deleted from an active domain then a search domain is deleted
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given an index has been deleted from an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then tags are added to a domain then a search domain finishes deleting
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given tags have been added to a domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then tags are removed from a domain then a domain configuration update is requested
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given tags have been removed from a domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then shards are reallocated across nodes in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given shards have been reallocated across nodes in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a replica sync lag event occurs on an active domain then an index is created in an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a replica sync lag event has occurred on an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a document is indexed in an active index then a node failure occurs in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given a document has been indexed in an active index
    Given a node failure has occurred in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain is created then tags are removed from a domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a search domain has been created
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain finishes creating then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a search domain has finished creating
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain is deleted then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a search domain has been deleted
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a search domain finishes deleting then a node failure occurs in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a search domain has finished deleting
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a domain configuration update is requested then a search domain is created
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a domain configuration update has been requested
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a domain finishes processing its configuration update then a search domain finishes creating
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a domain has finished processing its configuration update
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then an index is created in an active domain then a search domain is deleted
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given an index has been created in an active domain
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a document is indexed in an active index then a search domain finishes deleting
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a document has been indexed in an active index
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then tags are added to a domain then a domain configuration update is requested
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given tags have been added to a domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then tags are removed from a domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given tags have been removed from a domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then shards are reallocated across nodes in an active domain then an index is created in an active domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given shards have been reallocated across nodes in an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a replica sync lag event occurs on an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a replica sync lag event has occurred on an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: an index is deleted from an active domain then a node failure occurs in an active domain then tags are added to a domain
    Given domain in domain_status
    Given an index has been deleted from an active domain
    Given a node failure has occurred in an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain is created then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has been created
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain finishes creating then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has finished creating
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain is deleted then a node failure occurs in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has been deleted
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a search domain finishes deleting then a search domain is created
    Given domain in domain_status
    Given tags have been added to a domain
    Given a search domain has finished deleting
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a domain configuration update is requested then a search domain finishes creating
    Given domain in domain_status
    Given tags have been added to a domain
    Given a domain configuration update has been requested
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a domain finishes processing its configuration update then a search domain is deleted
    Given domain in domain_status
    Given tags have been added to a domain
    Given a domain has finished processing its configuration update
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then an index is created in an active domain then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been added to a domain
    Given an index has been created in an active domain
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a document is indexed in an active index then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been added to a domain
    Given a document has been indexed in an active index
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then an index is deleted from an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given tags have been added to a domain
    Given an index has been deleted from an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then tags are removed from a domain then an index is created in an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given tags have been removed from a domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then shards are reallocated across nodes in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given tags have been added to a domain
    Given shards have been reallocated across nodes in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a replica sync lag event occurs on an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a replica sync lag event has occurred on an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are added to a domain then a node failure occurs in an active domain then tags are removed from a domain
    Given domain in domain_status
    Given tags have been added to a domain
    Given a node failure has occurred in an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain is created then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has been created
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain finishes creating then a node failure occurs in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has finished creating
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain is deleted then a search domain is created
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has been deleted
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a search domain finishes deleting then a search domain finishes creating
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a search domain has finished deleting
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a domain configuration update is requested then a search domain is deleted
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a domain configuration update has been requested
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a domain finishes processing its configuration update then a search domain finishes deleting
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a domain has finished processing its configuration update
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then an index is created in an active domain then a domain configuration update is requested
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an index has been created in an active domain
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a document is indexed in an active index then a domain finishes processing its configuration update
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a document has been indexed in an active index
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then an index is deleted from an active domain then an index is created in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given an index has been deleted from an active domain
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then tags are added to a domain then a document is indexed in an active index
    Given domain in domain_status
    Given tags have been removed from a domain
    Given tags have been added to a domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then shards are reallocated across nodes in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given shards have been reallocated across nodes in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a replica sync lag event occurs on an active domain then tags are added to a domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a replica sync lag event has occurred on an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: tags are removed from a domain then a node failure occurs in an active domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given tags have been removed from a domain
    Given a node failure has occurred in an active domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain is created then a node failure occurs in an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a search domain has been created
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain finishes creating then a search domain is created
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a search domain has finished creating
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain is deleted then a search domain finishes creating
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a search domain has been deleted
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a search domain finishes deleting then a search domain is deleted
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a search domain has finished deleting
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a domain configuration update is requested then a search domain finishes deleting
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a domain configuration update has been requested
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a domain finishes processing its configuration update then a domain configuration update is requested
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a domain has finished processing its configuration update
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then an index is created in an active domain then a domain finishes processing its configuration update
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given an index has been created in an active domain
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a document is indexed in an active index then an index is created in an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a document has been indexed in an active index
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then an index is deleted from an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given an index has been deleted from an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then tags are added to a domain then an index is deleted from an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given tags have been added to a domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then tags are removed from a domain then tags are added to a domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given tags have been removed from a domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a replica sync lag event occurs on an active domain then tags are removed from a domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a replica sync lag event has occurred on an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: shards are reallocated across nodes in an active domain then a node failure occurs in an active domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given shards have been reallocated across nodes in an active domain
    Given a node failure has occurred in an active domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain is created then a search domain finishes creating
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a search domain has been created
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain finishes creating then a search domain is deleted
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a search domain has finished creating
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain is deleted then a search domain finishes deleting
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a search domain has been deleted
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a search domain finishes deleting then a domain configuration update is requested
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a search domain has finished deleting
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a domain configuration update is requested then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a domain configuration update has been requested
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a domain finishes processing its configuration update then an index is created in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a domain has finished processing its configuration update
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then an index is created in an active domain then a document is indexed in an active index
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given an index has been created in an active domain
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a document is indexed in an active index then an index is deleted from an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a document has been indexed in an active index
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then an index is deleted from an active domain then tags are added to a domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given an index has been deleted from an active domain
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then tags are added to a domain then tags are removed from a domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given tags have been added to a domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then tags are removed from a domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given tags have been removed from a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then shards are reallocated across nodes in an active domain then a node failure occurs in an active domain
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given shards have been reallocated across nodes in an active domain
    When a node failure occurs in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a replica sync lag event occurs on an active domain then a node failure occurs in an active domain then a search domain is created
    Given domain in domain_status
    Given a replica sync lag event has occurred on an active domain
    Given a node failure has occurred in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain is created then a search domain is deleted
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a search domain has been created
    When a search domain is deleted
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain finishes creating then a search domain finishes deleting
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a search domain has finished creating
    When a search domain finishes deleting
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain is deleted then a domain configuration update is requested
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a search domain has been deleted
    When a domain configuration update is requested
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a search domain finishes deleting then a domain finishes processing its configuration update
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a search domain has finished deleting
    When a domain finishes processing its configuration update
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a domain configuration update is requested then an index is created in an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a domain configuration update has been requested
    When an index is created in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a domain finishes processing its configuration update then a document is indexed in an active index
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a domain has finished processing its configuration update
    When a document is indexed in an active index
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then an index is created in an active domain then an index is deleted from an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given an index has been created in an active domain
    When an index is deleted from an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a document is indexed in an active index then tags are added to a domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a document has been indexed in an active index
    When tags are added to a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then an index is deleted from an active domain then tags are removed from a domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given an index has been deleted from an active domain
    When tags are removed from a domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then tags are added to a domain then shards are reallocated across nodes in an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given tags have been added to a domain
    When shards are reallocated across nodes in an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then tags are removed from a domain then a replica sync lag event occurs on an active domain
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given tags have been removed from a domain
    When a replica sync lag event occurs on an active domain
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then shards are reallocated across nodes in an active domain then a search domain is created
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given shards have been reallocated across nodes in an active domain
    When a search domain is created
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @sequence
  Scenario: a node failure occurs in an active domain then a replica sync lag event occurs on an active domain then a search domain finishes creating
    Given domain in domain_status
    Given a node failure has occurred in an active domain
    Given a replica sync lag event has occurred on an active domain
    When a search domain finishes creating
    Then every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"
