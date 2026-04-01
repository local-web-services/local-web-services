@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Is Deleted

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_elasticsearch_domain
  Scenario: an "elasticsearch" "domain" is deleted
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    When an "elasticsearch" "domain" is deleted
    Then the "elasticsearch" "domain" will be in "DELETING" state
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @delete_elasticsearch_domain
  Scenario: an "elasticsearch" "domain" is deleted fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "domain" is deleted
    Then the operation is rejected

  @guard @negative @delete_elasticsearch_domain @lifecycle
  Scenario: an "elasticsearch" "domain" is deleted fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When an "elasticsearch" "domain" is deleted
    Then the operation is rejected
