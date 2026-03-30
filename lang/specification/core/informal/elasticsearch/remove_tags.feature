@elasticsearch @generated
Feature: Elasticsearch - Tags Are Removed From A Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @remove_tags
  Scenario: tags are removed from a domain
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    And the tag key exists
    When tags are removed from a domain
    Then the specified tags are no longer associated with the domain
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the domain does not exist
    Given the domain does not exist
    When tags are removed from a domain
    Then the operation is rejected

  @guard @negative @remove_tags @lifecycle
  Scenario: tags are removed from a domain fails when the domain is being deleted
    Given the domain exists
    And the domain is being deleted
    When tags are removed from a domain
    Then the operation is rejected

  @guard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the domain is deleted
    Given the domain exists
    And the domain is not being deleted
    And the domain is deleted
    When tags are removed from a domain
    Then the operation is rejected

  @guard @negative @remove_tags
  Scenario: tags are removed from a domain fails when the tag key does not exist
    Given the domain exists
    And the domain is not being deleted
    And the domain is not deleted
    And the tag key does not exist
    When tags are removed from a domain
    Then the operation is rejected
