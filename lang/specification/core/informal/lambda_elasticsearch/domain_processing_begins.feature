@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - A "Elasticsearch" "Domain" Configuration Update Begins

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_begins
  Scenario: a "elasticsearch" "domain" configuration update begins
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    Then the "elasticsearch" "domain" will be "PROCESSING" and write operations may fail
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "elasticsearch" "domain" that exists

  @guard @negative @domain_processing_begins
  Scenario: a "elasticsearch" "domain" configuration update begins fails when the "elasticsearch" "domain" did not exist
    Given the "elasticsearch" "domain" did not exist
    When a "elasticsearch" "domain" configuration update begins
    Then the operation is rejected

  @guard @negative @domain_processing_begins @lifecycle
  Scenario: a "elasticsearch" "domain" configuration update begins fails when the "elasticsearch" "domain" was not "AVAILABLE"
    Given the "elasticsearch" "domain" existed
    And the "elasticsearch" "domain" was not "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    Then the operation is rejected
