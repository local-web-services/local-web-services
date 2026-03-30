@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The Lambda Function Indexes A Document Into The Available Domain And Succeeds

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document_task @internal
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given an invocation is "IN_PROGRESS"
    And the domain is "AVAILABLE"
    And a document slot is available
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then the document "EXISTS" and the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @guard @negative @index_document_task @internal
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then the operation is rejected

  @guard @negative @index_document_task @internal
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds fails when the domain is not "AVAILABLE"
    Given an invocation is "IN_PROGRESS"
    And the domain is not "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then the operation is rejected

  @guard @negative @index_document_task @internal
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds fails when no document slot is available
    Given an invocation is "IN_PROGRESS"
    And the domain is "AVAILABLE"
    And no document slot is available
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then the operation is rejected
