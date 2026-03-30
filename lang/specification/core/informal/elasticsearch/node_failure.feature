@elasticsearch @generated
Feature: Elasticsearch - A Node Failure Occurs In An Active Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @node_failure @internal
  Scenario: a node failure occurs in an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    When a node failure occurs in an active domain
    Then the domain enters "PROCESSING" state while recovering
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @node_failure @internal
  Scenario: a node failure occurs in an active domain fails when the domain does not exist
    Given the domain does not exist
    When a node failure occurs in an active domain
    Then the operation is rejected

  @guard @negative @node_failure @internal
  Scenario: a node failure occurs in an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a node failure occurs in an active domain
    Then the operation is rejected
