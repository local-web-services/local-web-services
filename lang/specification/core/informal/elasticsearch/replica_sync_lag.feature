@elasticsearch @generated
Feature: Elasticsearch - A Replica Sync Lag Event Occurs On An Active "Elasticsearch" "Domain"

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was "ACTIVE"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    Then the replica eventually catches up without changing document counts
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" fails when the "elasticsearch" "index" did not exist
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" did not exist
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @replica_sync_lag @internal
  Scenario: a replica sync lag event occurs on an active "elasticsearch" "domain" fails when the "elasticsearch" "index" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was not "ACTIVE"
    When a replica sync lag event occurs on an active "elasticsearch" "domain"
    Then the operation is rejected
