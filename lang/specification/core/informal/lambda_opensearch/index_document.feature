@lambdaopensearch @generated
Feature: LambdaOpensearch - The Lambda Function Indexes A Document Into The Opensearch Index During Invocation

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation
    Given an invocation is "IN_PROGRESS"
    And the index exists
    And the index's domain is "ACTIVE"
    And a document slot is available
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then the document is "INDEXED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @guard @negative @index_document @lifecycle
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @index_document @lifecycle
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation fails when the index does not exist
    Given an invocation is "IN_PROGRESS"
    And the index does not exist
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @index_document @lifecycle
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation fails when the index's domain is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the index exists
    And the index's domain is not "ACTIVE"
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then the operation is rejected

  @guard @negative @internal @index_document @capacity
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation fails when no document slot is available
    Given an invocation is "IN_PROGRESS"
    And the index exists
    And the index's domain is "ACTIVE"
    And no document slot is available
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then the operation is rejected
