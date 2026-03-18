@elasticsearch @generated
Feature: Elasticsearch - A Search Domain Finishes Creating

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_domain @internal
  Scenario: a search domain finishes creating
    Given the domain exists
    And the domain is "CREATING"
    When a search domain finishes creating
    Then the domain is "ACTIVE" and ready for use
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @finish_creating_domain @internal
  Scenario: a search domain finishes creating fails when the domain does not exist
    Given the domain does not exist
    When a search domain finishes creating
    Then the operation is rejected

  @standard @negative @finish_creating_domain @internal
  Scenario: a search domain finishes creating fails when the domain is not "CREATING"
    Given the domain exists
    And the domain is not "CREATING"
    When a search domain finishes creating
    Then the operation is rejected
