@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Finishes Processing Its Configuration Update

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_processing_domain_config @internal
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "PROCESSING"
    And the "elasticsearch" "domain" has a pending configuration change
    When an "elasticsearch" "domain" finishes processing its configuration update
    Then the "elasticsearch" "domain" will be "ACTIVE" with the new configuration applied
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @finish_processing_domain_config @internal
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "domain" finishes processing its configuration update
    Then the operation is rejected

  @guard @negative @finish_processing_domain_config @internal
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update fails when the "elasticsearch" "domain" was not "PROCESSING"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "PROCESSING"
    When an "elasticsearch" "domain" finishes processing its configuration update
    Then the operation is rejected

  @guard @negative @finish_processing_domain_config @internal
  Scenario: an "elasticsearch" "domain" finishes processing its configuration update fails when the "elasticsearch" "domain" does not have a pending configuration change
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "PROCESSING"
    And the "elasticsearch" "domain" does not have a pending configuration change
    When an "elasticsearch" "domain" finishes processing its configuration update
    Then the operation is rejected
