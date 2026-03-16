@elasticsearch @generated
Feature: Elasticsearch - A Document Is Indexed In An Active Index

  # Generated from FizzBee spec: elasticsearch.fizz
  # Safety invariants: IndicesHaveParentDomain, TagsHaveParentDomain, PendingConfigOnlyOnProcessingDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document
  Scenario: a document is indexed in an active index
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is "ACTIVE"
    When a document is indexed in an active index
    Then the document count for the index increases by one
    And every active index belongs to an existing non-deleted domain
    And every active tag belongs to an existing non-deleted domain
    And a pending config change only exists on a domain that is "PROCESSING"

  @standard @negative @index_document
  Scenario: a document is indexed in an active index fails when the domain does not exist
    Given the domain does not exist
    When a document is indexed in an active index
    Then the operation is rejected

  @standard @negative @index_document @lifecycle
  Scenario: a document is indexed in an active index fails when the domain is not "ACTIVE"
    Given the domain exists
    And the domain is not "ACTIVE"
    When a document is indexed in an active index
    Then the operation is rejected

  @standard @negative @index_document
  Scenario: a document is indexed in an active index fails when the index does not exist
    Given the domain exists
    And the domain is "ACTIVE"
    And the index does not exist
    When a document is indexed in an active index
    Then the operation is rejected

  @standard @negative @index_document
  Scenario: a document is indexed in an active index fails when the index is not "ACTIVE"
    Given the domain exists
    And the domain is "ACTIVE"
    And the index exists
    And the index is not "ACTIVE"
    When a document is indexed in an active index
    Then the operation is rejected
