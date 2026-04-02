@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Configuration Update Is Requested

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @update_elasticsearch_domain_config
  Scenario: an "elasticsearch" "domain" configuration update is requested
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    When an "elasticsearch" "domain" configuration update is requested
    Then the "elasticsearch" "domain" will be in "PROCESSING" state with a pending config change
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @update_elasticsearch_domain_config
  Scenario: an "elasticsearch" "domain" configuration update is requested fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "domain" configuration update is requested
    Then the operation is rejected

  @guard @negative @update_elasticsearch_domain_config @lifecycle
  Scenario: an "elasticsearch" "domain" configuration update is requested fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When an "elasticsearch" "domain" configuration update is requested
    Then the operation is rejected
