@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Index" Is Deleted From An Active "Elasticsearch" "Domain"

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @delete_index
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was "ACTIVE"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Then the "elasticsearch" "index" will be marked as "DELETED"
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @delete_index
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @delete_index @lifecycle
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @delete_index
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" fails when the "elasticsearch" "index" did not exist
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" did not exist
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @delete_index
  Scenario: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" fails when the "elasticsearch" "index" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was not "ACTIVE"
    When an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"
    Then the operation is rejected
