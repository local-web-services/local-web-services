@elasticsearch @generated
Feature: Elasticsearch - A Node Failure Occurs In An Active "Elasticsearch" "Domain"

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @node_failure @internal
  Scenario: a node failure occurs in an active "elasticsearch" "domain"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    When a node failure occurs in an active "elasticsearch" "domain"
    Then the "elasticsearch" "domain" will be in "PROCESSING" state while recovering
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @node_failure @internal
  Scenario: a node failure occurs in an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When a node failure occurs in an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @node_failure @internal
  Scenario: a node failure occurs in an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When a node failure occurs in an active "elasticsearch" "domain"
    Then the operation is rejected
