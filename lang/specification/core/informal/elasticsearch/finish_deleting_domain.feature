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
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

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
