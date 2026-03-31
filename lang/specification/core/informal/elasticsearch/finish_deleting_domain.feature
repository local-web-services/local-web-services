@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Domain" Finishes Deleting

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_domain @internal
  Scenario: an "elasticsearch" "domain" finishes deleting
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "DELETING"
    When an "elasticsearch" "domain" finishes deleting
    Then the "elasticsearch" "domain" will be "DELETED" and all its indices will be removed
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @finish_deleting_domain @internal
  Scenario: an "elasticsearch" "domain" finishes deleting fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "domain" finishes deleting
    Then the operation is rejected

  @guard @negative @finish_deleting_domain @internal
  Scenario: an "elasticsearch" "domain" finishes deleting fails when the "elasticsearch" "domain" was not "DELETING"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "DELETING"
    When an "elasticsearch" "domain" finishes deleting
    Then the operation is rejected
