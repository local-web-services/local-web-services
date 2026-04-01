@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The "Lambda" "Function" Fails To Write Because The "Elasticsearch" "Domain" Is Processing A Config Update

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_domain_processing
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticsearch" "domain" was "PROCESSING"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Then the invocation will be "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @guard @negative @invocation_fails_domain_processing @lifecycle
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Then the operation is rejected

  @guard @negative @invocation_fails_domain_processing @lifecycle
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update fails when the "elasticsearch" "domain" was not "PROCESSING"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticsearch" "domain" was not "PROCESSING"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Then the operation is rejected
