@elasticsearch @generated
Feature: Elasticsearch - A Domain Finishes Processing Its Configuration Update

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_processing_domain_config @internal
  Scenario: a domain finishes processing its configuration update
    Given the domain exists
    And the domain is "PROCESSING"
    And the domain has a pending configuration change
    When a domain finishes processing its configuration update
    Then the domain is "ACTIVE" with the new configuration applied
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @finish_processing_domain_config @internal
  Scenario: a domain finishes processing its configuration update fails when the domain does not exist
    Given the domain does not exist
    When a domain finishes processing its configuration update
    Then the operation is rejected

  @standard @negative @finish_processing_domain_config @internal
  Scenario: a domain finishes processing its configuration update fails when the domain is not "PROCESSING"
    Given the domain exists
    And the domain is not "PROCESSING"
    When a domain finishes processing its configuration update
    Then the operation is rejected

  @standard @negative @finish_processing_domain_config @internal
  Scenario: a domain finishes processing its configuration update fails when the domain does not have a pending configuration change
    Given the domain exists
    And the domain is "PROCESSING"
    And the domain does not have a pending configuration change
    When a domain finishes processing its configuration update
    Then the operation is rejected
