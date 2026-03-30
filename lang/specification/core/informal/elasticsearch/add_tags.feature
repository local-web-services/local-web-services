@elasticsearch @generated
Feature: Elasticsearch - Tags Are Added To A Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @add_tags
  Scenario: tags are added to a domain
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    When tags are added to a domain
    Then the specified tags are associated with the domain
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @add_tags
  Scenario: tags are added to a domain fails when the domain does not exist
    Given the domain does not exist
    When tags are added to a domain
    Then the operation is rejected

  @guard @negative @add_tags @lifecycle
  Scenario: tags are added to a domain fails when the domain is being deleted
    Given the domain exists
    And the domain is being deleted
    When tags are added to a domain
    Then the operation is rejected

  @guard @negative @add_tags
  Scenario: tags are added to a domain fails when the domain is deleted
    Given the domain exists
    And the domain is not being deleted
    And the domain is deleted
    When tags are added to a domain
    Then the operation is rejected
