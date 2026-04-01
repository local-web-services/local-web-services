@elasticsearch @generated
Feature: Elasticsearch - A "Elasticsearch" "Document" Is Indexed In An Active Index

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document
  Scenario: a "elasticsearch" "document" is indexed in an active index
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was "ACTIVE"
    When a "elasticsearch" "document" is indexed in an active index
    Then the "elasticsearch" "document" count for the "elasticsearch" "index" increases by one
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a "elasticsearch" "domain" that is "PROCESSING"

  @guard @negative @index_document
  Scenario: a "elasticsearch" "document" is indexed in an active index fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When a "elasticsearch" "document" is indexed in an active index
    Then the operation is rejected

  @guard @negative @index_document @lifecycle
  Scenario: a "elasticsearch" "document" is indexed in an active index fails when the "elasticsearch" "domain" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "ACTIVE"
    When a "elasticsearch" "document" is indexed in an active index
    Then the operation is rejected

  @guard @negative @index_document
  Scenario: a "elasticsearch" "document" is indexed in an active index fails when the "elasticsearch" "index" did not exist
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" did not exist
    When a "elasticsearch" "document" is indexed in an active index
    Then the operation is rejected

  @guard @negative @index_document
  Scenario: a "elasticsearch" "document" is indexed in an active index fails when the "elasticsearch" "index" was not "ACTIVE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "ACTIVE"
    And the "elasticsearch" "index" existed
    And the "elasticsearch" "index" was not "ACTIVE"
    When a "elasticsearch" "document" is indexed in an active index
    Then the operation is rejected
