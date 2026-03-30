@elasticsearch @generated
Feature: Elasticsearch - An Index Is Deleted From An Active Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_index
  Scenario: an index is deleted from an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is "ACTIVE"
    When an index is deleted from an active domain
    Then the index is marked as "DELETED"
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @delete_index
  Scenario: an index is deleted from an active domain fails when the domain does not exist
    Given the domain does not exist
    When an index is deleted from an active domain
    Then the operation is rejected

  @guard @negative @delete_index @lifecycle
  Scenario: an index is deleted from an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When an index is deleted from an active domain
    Then the operation is rejected

  @guard @negative @delete_index
  Scenario: an index is deleted from an active domain fails when the index does not exist
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not exist
    When an index is deleted from an active domain
    Then the operation is rejected

  @guard @negative @delete_index
  Scenario: an index is deleted from an active domain fails when the index is not "ACTIVE"
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is not "ACTIVE"
    When an index is deleted from an active domain
    Then the operation is rejected
