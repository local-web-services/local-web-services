@elasticsearch @generated
Feature: Elasticsearch - A Search Domain Is Deleted

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_elasticsearch_domain
  Scenario: a search domain is deleted
    Given the domain exists
    And the domain is "ACTIVE"
    When a search domain is deleted
    Then the domain is in "DELETING" state
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @delete_elasticsearch_domain
  Scenario: a search domain is deleted fails when the domain does not exist
    Given the domain does not exist
    When a search domain is deleted
    Then the operation is rejected

  @standard @negative @delete_elasticsearch_domain @lifecycle
  Scenario: a search domain is deleted fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a search domain is deleted
    Then the operation is rejected
