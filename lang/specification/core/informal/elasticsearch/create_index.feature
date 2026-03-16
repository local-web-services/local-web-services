@elasticsearch @generated
Feature: Elasticsearch - An Index Is Created In An Active Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_index
  Scenario: an index is created in an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not already exist
    When an index is created in an active domain
    Then the index is "ACTIVE" with zero documents
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @create_index
  Scenario: an index is created in an active domain fails when the domain does not exist
    Given the domain does not exist
    When an index is created in an active domain
    Then the operation is rejected

  @standard @negative @create_index @lifecycle
  Scenario: an index is created in an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When an index is created in an active domain
    Then the operation is rejected

  @standard @negative @create_index
  Scenario: an index is created in an active domain fails when the index already exists
    Given the domain exists
    And the domain is "ACTIVE"
    And the index already exists
    When an index is created in an active domain
    Then the operation is rejected
