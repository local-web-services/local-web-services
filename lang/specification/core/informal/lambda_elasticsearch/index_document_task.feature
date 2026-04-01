@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The "Lambda" "Function" Indexes A "Elasticsearch" "Document" Into The Available Domain And Succeeds

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @index_document_task @internal
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticsearch" "domain" was "AVAILABLE"
    And a "elasticsearch" "document" "slot" was "available"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Then the "elasticsearch" "document" will exist and the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "elasticsearch" "domain" that exists

  @guard @negative @index_document_task @internal
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Then the operation is rejected

  @guard @negative @index_document_task @internal
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds fails when the "elasticsearch" "domain" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticsearch" "domain" was not "AVAILABLE"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Then the operation is rejected

  @guard @negative @index_document_task @internal
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds fails when no "elasticsearch" "document" "slot" was "available"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticsearch" "domain" was "AVAILABLE"
    And no "elasticsearch" "document" "slot" was "available"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Then the operation is rejected
