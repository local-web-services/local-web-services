@elasticsearch @generated
Feature: Elasticsearch - A Search Domain Finishes Deleting

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting
    Given the domain exists
    And the domain is "DELETING"
    When a search domain finishes deleting
    Then the domain is "DELETED" and all its indices are removed
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting fails when the domain does not exist
    Given the domain does not exist
    When a search domain finishes deleting
    Then the operation is rejected

  @standard @negative @finish_deleting_domain @internal
  Scenario: a search domain finishes deleting fails when the domain is not "DELETING"
    Given the domain exists
    And the domain is not "DELETING"
    When a search domain finishes deleting
    Then the operation is rejected
