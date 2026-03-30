@elasticsearch @generated
Feature: Elasticsearch - A Domain Configuration Update Is Requested

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @update_elasticsearch_domain_config
  Scenario: a domain configuration update is requested
    Given the domain exists
    And the domain is "ACTIVE"
    When a domain configuration update is requested
    Then the domain is in "PROCESSING" state with a pending config change
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @update_elasticsearch_domain_config
  Scenario: a domain configuration update is requested fails when the domain does not exist
    Given the domain does not exist
    When a domain configuration update is requested
    Then the operation is rejected

  @guard @negative @update_elasticsearch_domain_config @lifecycle
  Scenario: a domain configuration update is requested fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a domain configuration update is requested
    Then the operation is rejected
