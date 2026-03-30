@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The Domain Configuration Update Completes

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_complete @internal
  Scenario: the domain configuration update completes
    Given the domain is "PROCESSING"
    When the domain configuration update completes
    Then the domain is "AVAILABLE" again
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @guard @negative @domain_processing_complete @internal
  Scenario: the domain configuration update completes fails when the domain is not "PROCESSING"
    Given the domain is not "PROCESSING"
    When the domain configuration update completes
    Then the operation is rejected
