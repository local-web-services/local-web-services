@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Is Created

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_elasticsearch_domain
  Scenario: an "elasticsearch" "domain" is created
    Given the "elasticsearch" "domain" did not already exist
    When an "elasticsearch" "domain" is created
    Then the "elasticsearch" "domain" will be in "CREATING" state
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @create_elasticsearch_domain
  Scenario: an "elasticsearch" "domain" is created fails when the "elasticsearch" "domain" already existed
    Given the "elasticsearch" "domain" already existed
    When an "elasticsearch" "domain" is created
    Then the operation is rejected
