@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Finishes Creating

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_domain @internal
  Scenario: an "elasticsearch" "domain" finishes creating
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "CREATING"
    When an "elasticsearch" "domain" finishes creating
    Then the "elasticsearch" "domain" will be "ACTIVE" and ready for use
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @finish_creating_domain @internal
  Scenario: an "elasticsearch" "domain" finishes creating fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "domain" finishes creating
    Then the operation is rejected

  @guard @negative @finish_creating_domain @internal
  Scenario: an "elasticsearch" "domain" finishes creating fails when the "elasticsearch" "domain" was not "CREATING"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "CREATING"
    When an "elasticsearch" "domain" finishes creating
    Then the operation is rejected
