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
    And a document slot is available
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the document will be "INDEXED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

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
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation fails when no document slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "opensearch" "index" existed
    And the "opensearch" "index"'s domain was "ACTIVE"
    And no document slot is available
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Then the operation is rejected
