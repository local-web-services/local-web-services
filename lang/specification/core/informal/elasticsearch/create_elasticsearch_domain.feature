@elasticsearch @generated
Feature: Elasticsearch - A Search Domain Is Created

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_elasticsearch_domain
  Scenario: a search domain is created
    Given the domain does not already exist
    When a search domain is created
    Then the domain is in "CREATING" state
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @create_elasticsearch_domain
  Scenario: a search domain is created fails when the domain already exists
    Given the domain already exists
    When a search domain is created
    Then the operation is rejected
