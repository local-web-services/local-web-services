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
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @create_elasticsearch_domain
  Scenario: an "elasticsearch" "domain" is created fails when the "elasticsearch" "domain" already existed
    Given the "elasticsearch" "domain" already existed
    When an "elasticsearch" "domain" is created
    Then the operation is rejected
