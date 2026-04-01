@elasticsearch @generated
Feature: Elasticsearch - Tags Are Added To An "Elasticsearch" "Domain"

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @add_tags
  Scenario: tags are added to an "elasticsearch" "domain"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" is not being deleted
    And the "elasticsearch" "domain" was not "DELETED"
    When tags are added to an "elasticsearch" "domain"
    Then the specified tags are associated with the "elasticsearch" "domain"
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @add_tags
  Scenario: tags are added to an "elasticsearch" "domain" fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When tags are added to an "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @add_tags @lifecycle
  Scenario: tags are added to an "elasticsearch" "domain" fails when the "elasticsearch" "domain" is being deleted
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" is being deleted
    When tags are added to an "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @add_tags
  Scenario: tags are added to an "elasticsearch" "domain" fails when the "elasticsearch" "domain" was "DELETED"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" is not being deleted
    And the "elasticsearch" "domain" was "DELETED"
    When tags are added to an "elasticsearch" "domain"
    Then the operation is rejected
