@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - A Domain Configuration Update Begins

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @domain_processing_begins
  Scenario: a domain configuration update begins
    Given the domain exists
    And the domain is "AVAILABLE"
    When a domain configuration update begins
    Then the domain is "PROCESSING" and write operations may fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @standard @negative @domain_processing_begins
  Scenario: a domain configuration update begins fails when the domain does not exist
    Given the domain does not exist
    When a domain configuration update begins
    Then the operation is rejected

  @standard @negative @domain_processing_begins @lifecycle
  Scenario: a domain configuration update begins fails when the domain is not "AVAILABLE"
    Given the domain exists
    And the domain is not "AVAILABLE"
    When a domain configuration update begins
    Then the operation is rejected
