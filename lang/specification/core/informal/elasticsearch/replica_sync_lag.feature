@elasticsearch @generated
Feature: Elasticsearch - A Replica Sync Lag Event Occurs On An Active Domain

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active domain
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is "ACTIVE"
    When a replica sync lag event occurs on an active domain
    Then the replica eventually catches up without changing document counts
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active domain fails when the domain does not exist
    Given the domain does not exist
    When a replica sync lag event occurs on an active domain
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active domain fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a replica sync lag event occurs on an active domain
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active domain fails when the index does not exist
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not exist
    When a replica sync lag event occurs on an active domain
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active domain fails when the index is not "ACTIVE"
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is not "ACTIVE"
    When a replica sync lag event occurs on an active domain
    Then the operation is rejected
