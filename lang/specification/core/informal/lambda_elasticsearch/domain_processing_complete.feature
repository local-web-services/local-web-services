@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The "Elasticsearch" "Domain" Configuration Update Completes

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_complete @internal
  Scenario: the "elasticsearch" "domain" configuration update completes
    Given the "elasticsearch" "domain" was "PROCESSING"
    When the "elasticsearch" "domain" configuration update completes
    Then the "elasticsearch" "domain" will be "AVAILABLE" again
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "elasticsearch" "domain" that exists

  @guard @negative @domain_processing_complete @internal
  Scenario: the "elasticsearch" "domain" configuration update completes fails when the "elasticsearch" "domain" was not "PROCESSING"
    Given the "elasticsearch" "domain" was not "PROCESSING"
    When the "elasticsearch" "domain" configuration update completes
    Then the operation is rejected
