@elasticsearch @generated
Feature: Elasticsearch - An "Elasticsearch" "Index" Is Created In An Active "Elasticsearch" "Domain"

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_index
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" did not already exist
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Then the "elasticsearch" "index" will be "ACTIVE" with zero documents
    And every active "elasticsearch" "index" belongs to an existing non-deleted "elasticsearch" "domain"
    And every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"
    And a pending config change only exists on an "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @create_index
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @create_index @lifecycle
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Then the operation is rejected

  @guard @negative @create_index
  Scenario: an "elasticsearch" "index" is created in an active "elasticsearch" "domain" fails when the "elasticsearch" "index" already existed
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" already existed
    When an "elasticsearch" "index" is created in an active "elasticsearch" "domain"
    Then the operation is rejected
