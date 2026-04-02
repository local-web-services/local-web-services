@lambdaopensearch @generated
Feature: LambdaOpensearch - The "Lambda" "Function" Indexes A Document Into The Opensearch Index During Invocation

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "opensearch" "index" existed
    And the "opensearch" "index"'s domain was "ACTIVE"
    And a "document" "slot" was "available"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the "opensearch" "document" will be "INDEXED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @guard @negative @index_document @lifecycle
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @index_document @lifecycle
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation fails when the "opensearch" "index" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "opensearch" "index" did not exist
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @index_document @lifecycle
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation fails when the "opensearch" "index"'s domain was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "opensearch" "index" existed
    And the "opensearch" "index"'s domain was not "ACTIVE"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @index_document @capacity
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation fails when no "opensearch" "document" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "opensearch" "index" existed
    And the "opensearch" "index"'s domain was "ACTIVE"
    And no "opensearch" "document" "slot" was "available"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the operation is rejected
