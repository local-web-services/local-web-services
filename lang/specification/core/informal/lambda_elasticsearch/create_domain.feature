@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - An Elasticsearch Domain Is Created And Becomes Available

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @create_domain
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE"
    Given the domain does not already exist
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then the domain is "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @standard @negative @create_domain
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" fails when the domain already exists
    Given the domain already exists
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then the operation is rejected
